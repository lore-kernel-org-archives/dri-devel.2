Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6240ECA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C031E10E82D;
	Fri,  9 Oct 2026 13:40:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BrDZvTl/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9CAA10E82D
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:40:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ACD344177E;
 Fri,  9 Oct 2026 13:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656BE1F000FF;
 Fri,  9 Oct 2026 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791553207;
 bh=Zd6XNNuVCTPm+Qu9gioaV7XptHPmXicBg3sohSlm4VQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BrDZvTl/T7I56VsjKJDuM8CoVfF5LT3nKeK316xgGTlLajsK4pY6UAv5H/+x54C79
 kISTylAO1afDVXkq+/ZcymcYqo6Qj3K5K3VNs442XreUOE24JVwhofMjK1UOHGErwj
 /Btv1YdzlQy/8eGAUTZgYOn+ocCX9tqY35h3Evq+lfKYxZ76uV282Zan+lmOxAI+My
 WA9QphN/tcWu1m06JDI01zDlRCOit0GvA3HTCSOXLhTjPF2bfrQnZV2wZQngPKn04u
 mEI/ZGcPXRWKIlpkWYfYVMvJYgeBH98xO6hFiMcozagNYi+eU2pcfZ/8gW8GJiebmd
 MyFcBoF+HNr1w==
Message-ID: <sashiko-outbox-165655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] drm/amdkfd: Fix use-after-free in the process
 creation error path
To: "Binbin Deng" <18983559317@163.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009132619.40151-1-18983559317@163.com>
References: <20261009132619.40151-1-18983559317@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:40:06 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] amdkfd: incomplete fix for UAF in create_process() error path
--

commit dcdae9cca3430fa247abfc570505faf612c7c75d
Author: Binbin Deng <18983559317@163.com>

drm/amdkfd: Fix use-after-free in the process creation error path

This commit attempts to fix a use-after-free race during process creation
by adding an SRCU grace period wait in the error path after removing the
process from the hash table.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1761,6 +1761,7 @@ struct kfd_process *create_process(const struct tas=
k_struct *thread, bool primar
>  	kfd_process_free_id(process);
>  err_register_notifier:
>  	hash_del_rcu(&process->kfd_processes);
> +	synchronize_srcu(&kfd_processes_srcu);

[Severity: High]
Does this synchronize_srcu() guarantee no threads are accessing the object
when we eventually reach kfree(process) at the end of the error path?

If a concurrent reader finds the process before it is removed from the hash
table, it will increment the reference count and then immediately drop the
SRCU lock:

kfd_lookup_process_by_mm() {
        ...
        p =3D find_process_by_mm(mm);
        if (p)
                kref_get(&p->ref);

        srcu_read_unlock(&kfd_processes_srcu, idx);
        ...
}

Because the concurrent reader has already dropped the SRCU lock,
synchronize_srcu() will return immediately.

The create_process() error path then continues tearing down the state and
eventually reaches the err_event_init label:

create_process() {
        ...
err_event_init:
        mutex_destroy(&process->mutex);
        kfree(process);
        ...
}

This unconditionally frees the process memory, completely bypassing the
kref mechanism.

Could this cause a use-after-free if the concurrent reader is still actively
holding and using the pointer?

>  	svm_range_list_fini(process);
>  err_init_svm_range_list:
>  	kfd_process_free_outstanding_kfd_bos(process);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009132619.4015=
1-1-18983559317@163.com?part=3D1
