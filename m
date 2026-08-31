Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2368CC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F3810E0CA;
	Mon, 31 Aug 2026 16:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I4k1oBcm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B04110E0CA
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:43:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 40C72601FB
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0891F000E9;
 Mon, 31 Aug 2026 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788194624;
 bh=Tcj/nMNskgB5GQg8WXn7wPIEBROKO0KxVzYKO16ALK4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I4k1oBcmRr1AkKLH7Fm/T30/Urw66UHow1IglTqZUNL66ahak1WBnZ/6LIncTSUZ8
 T9mxT4V9iNY/Ykdf05qIWnLDnlveQJNh8j1EaDjvFvZMPunrshWwMi8EMjb4tYNAjq
 +lNo0tb2AhMJRajHZ/NmD2zhggkxkxyJLXO+zUV4Go2fkT37O4o0kjI8l7Dw0bh/ss
 OS7yAReS5RjvDLBtObFRtAZ4QlfBwnlvK8QJ+CAm1Xvpv+t+h/HXgnr3ZjXXNKH7bR
 zPeBBKAhZsxz/feYCUe/a3DayF+wyz21lPgUlCuB+Ralkm7Jr7cSCeOIqTcbypUnea
 eDbzw7RnfzZLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] drm/amdkfd: Check bounds for
 allocate_sdma_queue restore_sdma_id
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-473-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-473-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:43:43 +0000
Message-Id: <20260831164343.CC0891F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing bounds check on user-supplied restore_id in allocate_doorb=
ell can lead to a heap out-of-bounds write.
- [High] Validation bypass in `kfd_ioctl_create_queue` when a device has no=
 SDMA engines, leading to an infinite loop and out-of-bounds memory access.
--

commit f2095bccc592ac2c6dbb0b7629acce3bdd15ede4
Author: David Francis <David.Francis@amd.com>

drm/amdkfd: Check bounds for allocate_sdma_queue restore_sdma_id

The allocate_sdma_queue function lacked bounds checking for a user-specified
SDMA queue ID during CRIU restore. This patch adds checks to ensure the ID
is less than the maximum number of queues, preventing out-of-bounds access.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 6e7bc983fc0b6..842720811599e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c

[ ... ]

> @@ -1622,6 +1625,9 @@ static int allocate_sdma_queue(struct device_queue_=
manager *dqm,
>  			return -ENOMEM;
>  		}
>  		if (restore_sdma_id) {
> +			if (*restore_sdma_id >=3D get_num_xgmi_sdma_queues(dqm))
> +				return -EINVAL;
> +
>  			/* Re-use existing sdma_id */
>  			if (!test_bit(*restore_sdma_id, dqm->xgmi_sdma_bitmap)) {
>  				dev_err(dev, "SDMA queue already in use\n");

[Severity: High]
This isn't a bug introduced by this patch, but there is a validation bypass=
 in
kfd_ioctl_create_queue() when a device has no SDMA engines, which can lead =
to
an infinite loop and out-of-bounds memory access here in allocate_sdma_queu=
e().

If an unprivileged user calls kfd_ioctl_create_queue() requesting
KFD_QUEUE_TYPE_SDMA_BY_ENG_ID on a device with 0 SDMA engines, both
kfd_get_num_sdma_engines() and kfd_get_num_xgmi_sdma_engines() evaluate to =
0.
This makes max_sdma_eng_id in kfd_ioctl_create_queue() evaluate to -1:

drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:kfd_ioctl_create_queue() {
    ...
		int max_sdma_eng_id =3D kfd_get_num_sdma_engines(dev) +
				      kfd_get_num_xgmi_sdma_engines(dev) - 1;

		if (q_properties.sdma_engine_id > max_sdma_eng_id) {
			err =3D -EINVAL;
    ...
}

Due to integer promotion, -1 is cast to 0xFFFFFFFF, bypassing the validatio=
n.

Execution then continues down to allocate_sdma_queue(), where the user-supp=
lied
sdma_engine_id is assigned to the int variable start_engine:

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:allocate_sdma_queue()=
 {
    ...
		start_engine =3D q->properties.sdma_engine_id - eng_offset;
		for (i =3D start_engine; i < num_queues; i +=3D num_engines) {

			if (!test_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap))
				continue;
    ...
}

With num_queues =3D=3D 0 and num_engines =3D=3D 0, if the user-supplied sdm=
a_engine_id
is negative when cast to int (e.g., -2147483648), start_engine becomes nega=
tive.
The condition (i < 0) is true and the loop becomes infinite (i +=3D 0). The
test_bit() function is then called with the negative index, leading to an
out-of-bounds memory access.

Could we add a check to ensure max_sdma_eng_id is >=3D 0 before doing the b=
ounds
check in kfd_ioctl_create_queue()?

[Severity: High]
This is a pre-existing issue, but this patch seems to have missed the
equivalent bounds check for allocate_doorbell().

A user process utilizing the KFD CRIU restore ioctl can provide a malicious
queue data structure with an arbitrarily large doorbell_id. When
create_queue_cpsch() calls allocate_doorbell(), this user-controlled ID
is passed as restore_id without validation:

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:allocate_doorbell() {
    ...
			if (__test_and_set_bit(*restore_id, qpd->doorbell_bitmap))
				return -EINVAL;
    ...
}

Since *restore_id isn't checked against KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
this results in a heap out-of-bounds write on the dynamically allocated
qpd->doorbell_bitmap array. This path is reachable via the KFD_IOC_CRIU_OP
ioctl which requires CAP_CHECKPOINT_RESTORE or CAP_SYS_ADMIN.

Is there a companion patch that adds the missing bounds check for
allocate_doorbell() as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-473-sashal@kernel.org?part=3D1
