Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C03FC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D44710F0BF;
	Thu, 27 Aug 2026 14:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cyGgIDBq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 809EF10F0BF
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:55:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 825D9600D3;
 Thu, 27 Aug 2026 14:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8621F000E9;
 Thu, 27 Aug 2026 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787842520;
 bh=yMfsVHo1v6LWvWfVIrIqN7rvoh3h2BxKsHv/RKB8rm0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cyGgIDBqK/b0O99nao36d6duJBuMVyr6M8T7InvAIF6Yr/VRy3YRGfUGSeSTki7jF
 3TJBCco3OUzk/9xUprCuHHZjAwwV+4a53W7vqsb30sUiZGWEG0UlYiPCWq8+m1dzTV
 4wS2IQ0cwl/zMQhUh4nfLXN0zXoSIL49l1M4Ofrh1fWtmmbLtHllN7oKcmq/ZvKlWW
 /58BkZ5znpm/jWIRZmUbRw2J9/7ESjn3Vgka8TCeKhW327wrNMDYOvveTN+pmLLLuj
 JUUzRcizC64FWvLN4Q06gtOTedSNM3MZG7cJMFoaDfge4B3QuQur72BTmXYO5zDKd9
 EBle7oQr74xfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/ras: drop redundant memset in
 amdgpu_virt_ras_get_cper_records()
To: "Sang-Heon Jeon" <ekffu200098@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827144614.487229-1-ekffu200098@gmail.com>
References: <20260827144614.487229-1-ekffu200098@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:55:19 +0000
Message-Id: <20260827145520.0D8621F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Medium] Missing buffer full check causes successful operations to fail w=
hen the buffer is perfectly filled.
--

commit 24dbd1a80d649ce6f08f74e92eab2a4b85e073a8
Author: Sang-Heon Jeon <ekffu200098@gmail.com>

drm/amd/ras: drop redundant memset in amdgpu_virt_ras_get_cper_records()

This commit drops a redundant memset() after kzalloc() since kzalloc()
already returns zeroed memory.

> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/driv=
ers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> index 1e83cb5064ff6..f021719ff0a8b 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> @@ -298,8 +298,6 @@ static int amdgpu_virt_ras_get_cper_records(struct ra=
s_core_context *ras_core,
>  		return RAS_CMD__ERROR_GENERIC;
>  	}
> =20
> -	memset(out_buf, 0, req->buf_size);
> -
>  	for (i =3D 0; i < req->cper_num; i++) {
>  		batch_id =3D req->cper_start_id + i;
>  		if (batch_id >=3D overview->last_batch_id)

[Severity: Medium]
This is a pre-existing issue, but while reviewing this function, I noticed a
potential issue if the buffer gets perfectly filled.

Further down in amdgpu_virt_ras_get_cper_records(), we have this sequence:

		if (count > 0) {
			ret =3D ras_cper_generate_batch_cper(ras_core, batch_logs, count,
					&out_buf[offset], req->buf_size - offset, &real_data_len);
			if (ret)
				break;

			offset +=3D real_data_len;
		}

If a previous iteration perfectly fills the buffer, offset will exactly equ=
al
req->buf_size.

On the next iteration, req->buf_size - offset will evaluate to 0.

ras_cper_generate_batch_cper() explicitly rejects a buffer length of 0 by
returning -EINVAL.

Because the caller treats -EINVAL as a fatal error (the check
ret && (ret !=3D -ENOMEM) evaluates to true), the function fails completely=
 and
discards the successfully retrieved records rather than returning them to t=
he
caller.

Could we add a check to break early if offset >=3D req->buf_size, similar to
how it is mitigated in ras_cmd_get_cper_records() in core/cmd.c?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827144614.4872=
29-1-ekffu200098@gmail.com?part=3D1
