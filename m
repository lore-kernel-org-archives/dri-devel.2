Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C80FFEDA0D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9B2E10E5E3;
	Tue, 17 Mar 2026 19:26:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mB3n68Fu";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CD110E5DE
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 19:26:31 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1277863a912so492295c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773775591; cv=none;
 d=google.com; s=arc-20240605;
 b=k6IkEhf/MLXSIYYIMUy0oYH7TMd/J52gNTzR5AbW4M/tOtyyBvHolnBzWUirweMVCn
 kdz1OFwIkMBVyxk7oYiwDelUsxpm581YAx9OCPXqcP0nWXuoZbNxrKP9OZCxHP/v1TdH
 7+dXSAjv4YfvxpMlCVwWSR6hTPFX9ZgjTpvVMtlMCcqaSSWHR+l9/C2/qZ0iLRJlEQKi
 5c0A5YMG4RuoPZG64e5Ews+vbf4VS6fgGGRFZS27NpSPeuu3PzbbAl3XIDRNKnlogc90
 Ptpm7B4GLTi/4LYN1JcXs0RDyhS0fxnDWL/SV79+WGT0LFoagqxeY7EPf6EAC1nisOKZ
 nyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v/qqkcjWxAT1BP4Oe26tlDpbbc2ZBX/lN25rud4FenQ=;
 fh=s1Dt0NWNttcXKYUnuFuJ1tiy9s6UBAGZAZY36hIFHaQ=;
 b=OmiWYZ2XsqlDGbeO65rcN/SROpYlEpSZ2m2QUogeWYtuInZKp9kQgjgOpAnCbdKOYe
 TeMw25+wKWTcBRMVtAH/2sXStsr9LNoZ8POkF8iaATSZu29jH/Fst7MU9pgoT8fzcq4b
 s8zfW+DW3f4qsTNI1Kn7iHh+ECDcC9ZfhMDUoNw3AGN6hjordKWX+7f6U+SGtdkAtrf+
 mlWnoA/u4XzG1k0t7jXWvwYBNKNw5GFQ22EF9g5YfC8e/Zq9xyDiSFJUyux/AaEdYzOT
 az4q/u6AGUfzaTYnPnY6dpMkpXMZ9uy10lwKczGUd7thgSflNr64bVNbnF++e3QUl9g1
 GY8g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773775591; x=1774380391; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/qqkcjWxAT1BP4Oe26tlDpbbc2ZBX/lN25rud4FenQ=;
 b=mB3n68FuL5ZeiEo7WuPWYq7XyLeR5qpCx9lvZo7/PXLgPiF7FV+wlXwDnMzfVeBd9P
 AzSIcmgYuqgWK9ZYdGpB+ZWo/Vt3fBKn9sUlf9/isnzlJlb0sfkxa8p63J+3VX8Ur5hX
 ghfo+PYMXhc1B2GGwqcQtIEuXZlzgsXzQJH5Ac38UagkYMY3/nuaVptYFPZroELk704f
 1CbyiIE3NRDqWOJd/GLoRB0Dn1Vrxj2VfDfzf+ucHYVcEbkUsCcTwRzmjYHZf2ExrLUc
 12zNRuU8brCTgzDNQyz6VSYohJj0OJmlEP4gR+lpaEyvFHYDRpqi3gXnkT7FLQ4wJZT2
 7TUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773775591; x=1774380391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v/qqkcjWxAT1BP4Oe26tlDpbbc2ZBX/lN25rud4FenQ=;
 b=eUHZzRpUtxFN7p+PbxDfqBJzdAb0fA4RB5WHlkv50Yagv5tMk2F+S3UdFB+U7qezAY
 g2Ulf2/oeDqYYS+9fuXBxM/kbxAWwc063p+fUat84n5PbLsasjLVF77l1ROE1BG9r1cV
 VasfgRbzDvsqgTJBFuGhlnurPDBbAZP7u1+UV9H1emBN77e43mD8BDJGrlkMmiJXIO7B
 ClbjU9EarE/B59QJ1f3RsmSdveXJZEMCvjt/vWo514DAVQ5GYEqiWji6HEcUJ68OL946
 IrBzWw/+Zfsk2k/LuBPl4WNL10Hf1LK9sV/dwvFh+8tDlTodrhh4HsL2YlZHc4YWi0HI
 T/Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2dkv9lzgqvsHKiMdZx4EWzBhoS7GgDLiqRSSKROX7RMo5S7BzfhWw5RsUXRJsBTRYYCLwLe9FbxI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8V5BhkRGNBHJRKwpCvQrQNNhthScMhl5EDE8csnzGFVEB7dxR
 pLmhBjWvqrT9XvpJdiL/nM2vvQSNFw70gfZK4zYHQOWa3Ef7txry94fmBOjzXlUTC+nq9N72Nez
 1DKKvF36YAkd7AqLstkQJs8IF72F7jjo=
X-Gm-Gg: ATEYQzxwJm5Tcm0iskDb4EfuXuoRcL3RKq9OVEGR9Xxi4WasXImJMH9EGCWVS0V4p3s
 R4j02mJs8gdNaEQvh+W5lelXAdxrsijmVxH19wSvkggYILMC5MOpmrp/BZHUAShIa8QETdFNwiK
 mg2SO10gWakL4fmVE2mGGq39be0weBZXDvG9Qcl8XSOlgHU7ExTL1MXXgGEX5y1wfw4njdGvbmt
 jc2hloPwXOEX0Kv2cVChSjcSLMuTZAXQeVMabL7fdcx2g40R7hwvwiH/HMYlp84+ihjPUWjAGmS
 0n2AxF6QwazR5ryq8D49Lvn0eHIO2pIugVNn0c2ouWKJwhn2TBlhnpKcj4EU2Oz/H6Ab0Q==
X-Received: by 2002:a05:7022:e1d:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-129a70e7b23mr184416c88.4.1773775590538; Tue, 17 Mar 2026
 12:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260316214041.6275-1-litaliano00.contact@gmail.com>
In-Reply-To: <20260316214041.6275-1-litaliano00.contact@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Mar 2026 15:26:19 -0400
X-Gm-Features: AaiRm52jEQOolaGCdY9-TL50CGZmnuL6QPn0YVDIDX2_OK4FKM8bFWmsyoA4n_4
Message-ID: <CADnq5_MN=TTOHc86oxEuApUMCc9R57MxQvF82uyYh_fsMou1Ew@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: clean up typecasts and ordering in
 dcn4_calcs
To: Adriano Vero <litaliano00.contact@gmail.com>
Cc: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com, 
 sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Mar 17, 2026 at 4:18=E2=80=AFAM Adriano Vero
<litaliano00.contact@gmail.com> wrote:
>
> Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
> ---
>  .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dm=
l2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2=
_core/dml2_core_dcn4_calcs.c
> index ca5ac3c0d..3e63320fd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core=
_dcn4_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core=
_dcn4_calcs.c
> @@ -12670,7 +12670,7 @@ static void rq_dlg_get_dlg_reg(
>                         disp_dlg_regs->refcyc_per_vm_req_flip =3D (unsign=
ed int)(math_pow(2, 23) - 1);
>
>
> -               DML_ASSERT(disp_dlg_regs->dst_y_after_scaler < (unsigned =
int)8);
> +               DML_ASSERT(disp_dlg_regs->dst_y_after_scaler < (int unsig=
ned)8);

Isn't this just doing what you are claiming to fix?

>                 DML_ASSERT(disp_dlg_regs->refcyc_x_after_scaler < (unsign=
ed int)math_pow(2, 13));
>
>                 if (disp_dlg_regs->dst_y_per_pte_row_nom_l >=3D (unsigned=
 int)math_pow(2, 17)) {
> @@ -13226,7 +13226,7 @@ void dml2_core_calcs_get_informative(const struct=
 dml2_core_internal_display_mod
>
>         out->informative.misc.cstate_max_cap_mode =3D dml_get_cstate_max_=
cap_mode(mode_lib);
>
> -       out->min_clocks.dcn4x.dpprefclk_khz =3D (int unsigned)dml_get_glo=
bal_dppclk_khz(mode_lib);
> +       out->min_clocks.dcn4x.dpprefclk_khz =3D (unsigned int)dml_get_glo=
bal_dppclk_khz(mode_lib);
>
>         out->informative.qos.max_active_fclk_change_latency_supported =3D=
 dml_get_fclk_change_latency(mode_lib);
>
> --
> 2.47.3
>
