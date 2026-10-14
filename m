Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49422CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3DFF10FEDC;
	Wed, 14 Oct 2026 16:08:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C4C110FED5
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:08:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D8FB60229;
 Wed, 14 Oct 2026 16:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C767B1F000C5;
 Wed, 14 Oct 2026 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791994081;
 bh=Bv73iyadVQ67bnq00A+ChXym7wHBc9O9r4vRPKrK2uc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZsZh5DfP8mB5DvlN5BTaB9F0vCVyxXGZvhLdL5MfzI2kNxIoqF226EQ6Bi1yW1swP
 pwsPsStFkEHLJqZvklucA17E51y0fDrdeztQVFM2bZ2+CWs/qUFHQgavFTz0uQREDC
 KyIE1CQ1CIllA6w8IAKTJRvnNphtotgfxQLi43dlUQnaaLW5ODft0ApskW0mHQzyiR
 4q+9Lk9PLQDy9Vw+M+ZyDUrFuIHzK5UXTBKJ9nguo7Pni0uydKECPYHOL+lELBxhJC
 Hp98vw2a5wx7P7AYZoh5GFoqJb1Ch0lFhdh/wyrDid3gxfYfbTYXHuw7PWAItUwqZ1
 wSzhEYytHzi6Q==
Message-ID: <sashiko-outbox-171514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/amdkfd: fix doorbell allocation race creating
 duplicate allocations
To: "Felix Kuehling" <felix.kuehling@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014154959.540809-1-felix.kuehling@amd.com>
References: <20261010030230.1764682-1-bsdhenrymartin@gmail.com>
 <20261014154959.540809-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 16:08:01 +0000
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
- [Medium] drm/amdkfd: pdd memory leak on kfd_init_apertures() error path
--

commit d555bec2fa5191157e4dad2138f047c49150f26e
Author: Henry Martin <bsdhenrymartin@gmail.com>

    drm/amdkfd: fix doorbell allocation race creating duplicate allocations

This patch introduces a per-process-device mutex to serialize process doorb=
ell
allocation. It adds mutex initialization and destruction to the kfd process
lifecycle.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 226f52626e849..51b0df4984945 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c

[ ... ]

> @@ -1802,6 +1803,7 @@ struct kfd_process_device *kfd_create_process_devic=
e_data(struct kfd_node *dev,
>  	pdd->dev =3D dev;
>  	INIT_LIST_HEAD(&pdd->qpd.queues_list);
>  	INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
> +	mutex_init(&pdd->doorbell_mutex);
>  	pdd->qpd.dqm =3D dev->dqm;
>  	pdd->qpd.pqm =3D &p->pqm;
>  	pdd->qpd.evicted =3D 0;

[Severity: Medium]
Will this mutex and the pdd struct be leaked if kfd_init_apertures() fails?

Looking at create_process(), if kfd_init_apertures() successfully allocates
one or more pdd structs but then encounters an error and fails, the error
handling path jumps to err_init_apertures:

create_process() {
    ...
    err =3D kfd_init_apertures(process);
    if (err !=3D 0)
        goto err_init_apertures;
    ...
err_init_svm_range_list:
    kfd_process_free_outstanding_kfd_bos(process);
    kfd_process_destroy_pdds(process);
err_init_apertures:
    pqm_uninit(&process->pqm);
    ...
}

Because err_init_apertures bypasses the call to kfd_process_destroy_pdds(),
does this mean the newly initialized doorbell_mutex and the allocated pdd
structs are leaked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014154959.5408=
09-1-felix.kuehling@amd.com?part=3D1
