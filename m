Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDCCC88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 09:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A90DF10E475;
	Sat, 12 Sep 2026 09:16:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NjXw/E/z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D322310E475;
 Sat, 12 Sep 2026 09:16:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A152743C5F;
 Sat, 12 Sep 2026 09:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9ED1F00893;
 Sat, 12 Sep 2026 09:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789204605;
 bh=QMxsZXNPdDP3OZk5rsIfOjPSh0zNAysLpZcCsrjSshM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NjXw/E/zcINWxWn6qbuKHE8G595yGzkvJBThkzA/Nsqgua6H9k2oEZ/K7mQjpqhLi
 8colEJuf7ZnoniA4EqhW0c8junCx2Xb66vPkJ3K662K+bY4q0RSH80wgZzlyRXGojR
 ySp7/etqWA8cG2oQ2rpr4DzVTB0DOLabHv8F6fq89wuuHR5jw2JNhPw6tPIpvWiHmp
 m/wnfoUjHNfuA8BgwWar760QDgrwzvyvpLkcUgY9Z9UEtkMfq+UksrB8PHfVuIzUhC
 Buv1qlQG3pfDlqL8VJVWB0c6JgFc5YLAf3EuVwt+VrhuYqeigeaUx6s8HJg1UVnJHu
 c/zlG8tcZfAXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/xe/i2c: cancel the client work on remove
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260912085932.101598-1-fanwu01@zju.edu.cn>
References: <20260912085932.101598-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 09:16:44 +0000
Message-Id: <20260912091645.4E9ED1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Late work cancellation creates an unsynchronized data race and res=
ource leak on the i2c->client array.

Pre-existing issues:
- [High] Dangling pointers in xe->i2c and i2c->amc cause a use-after-free w=
hen handling I2C SMBus alert interrupts due to devm teardown order.
--

commit 6a096e96b5e0c4286797ea9eb48856f09bbb9287
Author: Fan Wu <fanwu01@zju.edu.cn>
Subject: drm/xe/i2c: cancel the client work on remove

This commit aims to fix an issue in xe_i2c_remove() where i2c->work is not
drained before unregistering the adapter. It adds a call to cancel_work_syn=
c()
after bus_unregister_notifier() to prevent a use-after-free if the work runs
after the adapter is unregistered.

Link: https://lore.kernel.org/r/20260909052328.654682-1-fanwu01@zju.edu.cn

> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> index d8fa68206f418..143ca7145e4f4 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
> @@ -334,6 +334,7 @@ static void xe_i2c_remove(void *data)
>  	}
> =20
>  	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
> +	cancel_work_sync(&i2c->work);

[Severity: High]
Does placing the work cancellation here introduce a data race with the clie=
nt
unregistration loop?

Since cancel_work_sync() is executed after the loop that clears i2c->client
in xe_i2c_remove(), xe_i2c_client_work() can run concurrently on another CP=
U:

CPU1 (in xe_i2c_remove)                 CPU2 (in xe_i2c_client_work)
for (i =3D 0; i < XE_I2C_MAX_CLIENTS; i++) {
    i2c_unregister_device(i2c->client[i]);
    i2c->client[i] =3D NULL;
}
                                        i2c->client[XE_I2C_CLIENT_AMC] =3D
                                            i2c_new_client_device(...);
cancel_work_sync(&i2c->work);

If the worker writes to the array after the loop has passed the index or
finished entirely, the newly created client device is leaked.

Could cancel_work_sync() and bus_unregister_notifier() be moved to the
beginning of the removal function to prevent this?


[Severity: High]
This isn't a bug introduced by this patch, but does this devres teardown pa=
th
leave dangling pointers that could cause a use-after-free during an SMBus
alert interrupt?

In xe_i2c_remove(), xe_amc_exit() is called before we reach this point, whi=
ch
frees i2c->amc:

drivers/gpu/drm/xe/xe_amc.c:xe_amc_exit() {
    ...
    cancel_work_sync(&i2c->amc->work);
    kfree(i2c->amc);
}

Since i2c->amc is not set to NULL, and hardware interrupts are not disabled=
 in
xe_i2c_remove(), a concurrent or subsequent interrupt can trigger the alert
handler:

drivers/gpu/drm/xe/xe_i2c.c:xe_i2c_handle_smbus_alert() {
    ...
    if (stat & DW_IC_SMBUS_INTR_ALERT && i2c->amc)
        xe_amc_handle_alert(i2c);
}

This calls into xe_amc_handle_alert() which dereferences the freed memory to
queue the work item:

drivers/gpu/drm/xe/xe_amc.c:xe_amc_handle_alert() {
    ...
    queue_work(system_long_wq, &i2c->amc->work);
}

Additionally, xe->i2c is not set to NULL before the devm subsystem frees the
i2c structure, so the active interrupt handler xe_i2c_irq_present() can also
dereference the dangling xe->i2c pointer.

Should hardware interrupts be disabled and these pointers cleared in this
removal function?

>  	xe_i2c_unregister_adapter(i2c);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912085932.1015=
98-1-fanwu01@zju.edu.cn?part=3D1
