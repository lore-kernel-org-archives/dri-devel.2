Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE75C43211
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 13:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7663E10E4E2;
	Sat, 27 Jun 2026 13:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VK0EQZxI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67EA110E4DB
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 50C7A44078
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5771F000E9;
 Sat, 27 Jun 2026 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782567754;
 bh=LAGsV7Z2YPkYpZlnTLDUsTWHmQJEajK0cdxBLsA023o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VK0EQZxIweyVQ281IXIUzHiFo8rkgbhCDH8sl7lBb6jmqUjo0zMzrnvugq99Q/wqP
 vMR9tar3XsQcISnoIUWTENqykv1DZTXXBrc8qr4x6d6glnYnRMN4iaO4U2HLY3N1X+
 ZzT2tpEoBkybx7NJ0vMuX85n8xXG+V1PRQP4STU17sVCaG9cc1JT+d366s4H2USw5A
 1tRUix24bbK+LLGBNRtiyy0+CsYmu1s4Hc/wRE/WFQrDhfQV5i1weLPWBh38FMQ7t9
 AQGNOsAinR1S9OVGe7kLD7WVsZGurAHIJRh2Wb4QHV3UwMHgxCiGKwFEm7qeAIpV0n
 k8f4uiPxC9RXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/14] wifi: ath12k: Switch to generic PAS TZ APIs
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626133440.692849-13-sumit.garg@kernel.org>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 13:42:33 +0000
Message-Id: <20260627134234.0D5771F000E9@smtp.kernel.org>
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
- [High] Missing `qcom_pas_shutdown()` on error and timeout paths in `ath12=
k_ahb_power_up()` and `ath12k_ahb_power_down()`.
- [High] Missing `reinit_completion()` for UserPD completions before reuse.
--

commit 64d57b3ec944d7af7a51a4d0a20ee4f202c079f4
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

wifi: ath12k: Switch to generic PAS TZ APIs

Switch ath12k client driver over to generic PAS TZ APIs. Generic PAS TZ
service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless=
/ath/ath12k/ahb.c
> index 30733a244454e..d9717ea999d72 100644
> --- a/drivers/net/wireless/ath/ath12k/ahb.c
> +++ b/drivers/net/wireless/ath/ath12k/ahb.c
> @@ -420,7 +420,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
> =20
>  	if (ab_ahb->scm_auth_enabled) {
>  		/* Authenticate FW image using peripheral ID */
> -		ret =3D qcom_scm_pas_auth_and_reset(pasid);
> +		ret =3D qcom_pas_auth_and_reset(pasid);
>  		if (ret) {
>  			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
>  			goto err_fw2;
>  		}
>  	}
>=20
>  	/* Instruct Q6 to spawn userPD thread */
>  	ret =3D qcom_smem_state_update_bits(ab_ahb->spawn_state, BIT(ab_ahb->sp=
awn_bit),
>  					  BIT(ab_ahb->spawn_bit));
>  	if (ret) {
>  		ath12k_err(ab, "Failed to update spawn state %d\n", ret);
>  		goto err_fw2;
>  	}
>=20
>  	time_left =3D wait_for_completion_timeout(&ab_ahb->userpd_spawned,
>  						ATH12K_USERPD_SPAWN_TIMEOUT);

[Severity: High]
This is a pre-existing issue, but does this wait_for_completion_timeout()
need a matching reinit_completion() before it?

If a previous wait timed out but the interrupt fired late, the completion
might contain a stale done count. Would the next attempt to power up
incorrectly return immediately, allowing the driver to proceed before the
firmware is actually ready?

>  	if (!time_left) {
>  		ath12k_err(ab, "UserPD spawn wait timed out\n");
>  		ret =3D -ETIMEDOUT;
>  		goto err_fw2;

[Severity: High]
This is also a pre-existing issue, but if the wait times out, this path
jumps to err_fw2.

Does jumping to err_fw2 without calling qcom_pas_shutdown() leak the PAS
resources? If the TrustZone state machine is left in an active state, will
it permanently reject subsequent authentication attempts until a reboot?

[ ... ]

> @@ -485,10 +485,10 @@ static void ath12k_ahb_power_down(struct ath12k_bas=
e *ab, bool is_suspend)
>  	unsigned long time_left;
>  	u32 pasid;
>  	int ret;
>=20
>  	qcom_smem_state_update_bits(ab_ahb->stop_state, BIT(ab_ahb->stop_bit),
>  				    BIT(ab_ahb->stop_bit));
>=20
>  	time_left =3D wait_for_completion_timeout(&ab_ahb->userpd_stopped,
>  						ATH12K_USERPD_STOP_TIMEOUT);
>  	if (!time_left) {
>  		ath12k_err(ab, "UserPD stop wait timed out\n");
>  		return;

[Severity: High]
This is a pre-existing issue, but if the stop wait times out, the function
returns early without clearing the stop smem state bit or calling
qcom_pas_shutdown().

Can this cause the PAS memory and remote processor resources to leak and
break the TrustZone state machine on subsequent power ups?

>  	}
>=20
>  	qcom_smem_state_update_bits(ab_ahb->stop_state, BIT(ab_ahb->stop_bit), =
0);
>=20
>  	if (ab_ahb->scm_auth_enabled) {
>  		pasid =3D (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
>  			 ATH12K_AHB_UPD_SWID;
>  		/* Release the firmware */
> -		ret =3D qcom_scm_pas_shutdown(pasid);
> +		ret =3D qcom_pas_shutdown(pasid);
>  		if (ret)
> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> -				   ab_ahb->userpd_id);
> +			ath12k_err(ab, "pas shutdown failed for userPD%d: %d\n",
> +				   ab_ahb->userpd_id, ret);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626133440.6928=
49-1-sumit.garg@kernel.org?part=3D12
