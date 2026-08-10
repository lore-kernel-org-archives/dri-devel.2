Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D23C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3216810EA00;
	Mon, 10 Aug 2026 22:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b/l7q4F1";
	dkim-atps=neutral
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 818E910E09D
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 22:32:03 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-451a49abd8aso1234194fac.3
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 15:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786401122; cv=none;
 d=google.com; s=arc-20260327;
 b=GJRZdaKysIKtR4T2LWFeTokiJ52IpB6QKSZb1J5nHOjXRmI2lSUNcV+XKMggrFRALe
 f+EiM1jLrSyTM9fvzOCi1B/NlNnrCXiX56uqTKVq4Bx4gd7TpDr9N09x0P+ciroFMorE
 folkjukuQp43yZgStP0MF1MMEw8dQ4l6gnD/rZo5lstvQJqfv9hOopA84eXAeLRR+DPO
 gQa1l9vUI8wCBmuzSckQgCdVHRa8p3NoWrIo5chr6PyS0v+F3NIKVLY1SaubhsNSrahH
 5DltFO/UYhuziJ7F5pXVEw3JyiycQBsY3BHwzvRa7dzazcffwMDwz5L9lhxU/y5yeHP+
 fbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zyxXtENBpyFNsNuf38voWr1wQ1uEtNHDyiKrmTqUuxg=;
 fh=IHKSE05UL95S75iNX31OKIAP6ChgRfgKtgbrCoYkux4=;
 b=Lssy+EHaOCB+x6vNDsZpuLTGwNlbc2xJ5UGaNR50OF/3KfMsbv9kWkffG3fLUYUxux
 XOmw6rs2/LdN0rHUTQ/y2lIGE27zCIg+3zXMqJm8g6UBC50hlQH0t9SB0G1uAv3egBQO
 y3L8lEVG+75jeqCNXJ0oxr+7DQGPYCCuQcl+QHQ9hg44JMMPelpzyVjoIbJas0W4Ubv1
 k5oLu5P7l3xAq06zclncUyLJe4HLEJsBMMyCnomtP1uhEX1qzBBtUB8C88dX9ciqw2FH
 I6j8CwZ8SH0dQ1QsOZBixgbimeSn0yQIqpuVMyrh13jLhN5SDqjTJPIjLgEmodQlVuhW
 eL2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786401122; x=1787005922; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zyxXtENBpyFNsNuf38voWr1wQ1uEtNHDyiKrmTqUuxg=;
 b=b/l7q4F1ANeRr1F0D+YASwmlUdm03H/niyRPnybJ7PJTzH+reqap6yrgf/uFsiFc/v
 YG1MfnrOxt0akbYT3PazyNXLqj1lZPEp9XfubVgelhAplvek5BXBRFmzdy9MtSVaS1Eu
 bGbwe8hNTDk48z7a4+GmzyYMQmz0Iv+br9Xx2bd90gK24oWx5VQhVE1adx9ZH4i+ECp3
 BqJ9RWqBnPCbsuK8+Nlo2W7BoUEQEuODhSWYvrwR7kbSDQ61xk+roy0jIpm/fWvWkBeD
 LAcK/w3tvWd5cYgwK4EVSHV9381ZPxUCkATOkNZhZEgWNrsaSbwabcpThNcaF4Jiti3A
 bFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786401122; x=1787005922;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zyxXtENBpyFNsNuf38voWr1wQ1uEtNHDyiKrmTqUuxg=;
 b=nYrzEKlnZ4hOA23NDmOTnPWpB+Dxgb5idJCH1PUxUsPLWbj5/6TXT+sc2i9h+g8pXE
 q6uQurpxwNm2fc2boNwYUlWex/qfhNNEE6d8xipBb4x9SM71ig3CVnGq+7MEh1hF1BV3
 PY2PV7umeCbKTLNudwYrrgdgOrYVPNk2CqCXdiNYd5ckSVEf5RLsRv9/FpzjFC6VJy1D
 WqO6NT2Tz3FOT9ZgyJs+u0QrCklj8F92e4klpOiL57wtviJTCk1FrgKKulorrZSvDgQU
 SiPa1GbTRfk6kOOL1X4eGUmKqrYxYO6M8G0kuotBd7mrjkiT3IQjnsYJl+ihDZGb0dJV
 YBwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoV3cSO4vPvF1a4H62nUQ38stKHNAK/WdZx9wfaKTWRz54Zwq3tDeb/kLJX92m4XusT2l9uexWlxEA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzC9bdIfbjRTiMuPJtnjPkPRGviSJqAxzs02rVGS3/bUI1ilDDP
 3BG+sUJWB0c8MyzadQjT5tUDaoIMvcHn4J//RzJbGGiCW0tB05cKg5sZgonWwB9g2l3X2xSfYaw
 9zMtEyQARkQEIZSTcRQdkHEFjAz+qgsE=
X-Gm-Gg: AR+sD11DD7GNamJGtpD8SJ1/j/TxmqV4JjjWsnnR5IDvL2kdFosFA/xVwqo+R2dhgUQ
 WwwLskwkMBasFw7jGtWmBptPoDT17Kt6YosDaEp+kGSK+VGncIgfKRe9R0ML0iDIvpNA4KcRHna
 dTZZGByoOXVJi55/wUXmo2EPfygiZcyJPMqNlu8o62Iqp3SaL5GMiMNSukYtIbHxo9VX0x1dZmf
 CIXkMMhmxXySOipusnoYFewLG6Ez4zojvRbArcxJKtn8QwjKhFj2jxGz8OIygYwYrd3ilxbn+j2
 KqH5Vg+2ua8AOGiWCveL28QldtaGt4/4LYhSJtgNn+y7qBXFoQ6gwqtm
X-Received: by 2002:a05:6871:eb14:b0:409:5241:8abc with SMTP id
 586e51a60fabf-459ffc96be9mr14219832fac.20.1786401122585; Mon, 10 Aug 2026
 15:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260807182724.51018-1-edu042sjroy@proton.me>
 <CACNCB+=r4dAU4+WF2wGzsedbP67ZztWb8xE=CHgAf92BUhmxzA@mail.gmail.com>
 <TfUyS8ZAROFt0PXoGV7cW9HCmJCeX30V7o6BJSHAQOkc5aUVRYg5x0Bzui1uOBd5b1jXlYkwajcV4Z0_wSDRSHVaAcnu8HbjDYqhGD6q0Tg=@proton.me>
In-Reply-To: <TfUyS8ZAROFt0PXoGV7cW9HCmJCeX30V7o6BJSHAQOkc5aUVRYg5x0Bzui1uOBd5b1jXlYkwajcV4Z0_wSDRSHVaAcnu8HbjDYqhGD6q0Tg=@proton.me>
From: Nathan Lucas <nlucasgit@gmail.com>
Date: Mon, 10 Aug 2026 16:31:51 -0600
X-Gm-Features: AUfX_mwWXSS48fnafVI5tybbDEohF5POqvdUB9mQHhCRVov_4uA_RvOrYmLge74
Message-ID: <CACNCB+=cv9gBMLKxz+1e8=yFCC4PbKR0z4sh_jVEXPif1PG_zg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix BT2020 YCbCr limited range output CSC
To: edu042sjroy@proton.me
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, Ilya.Bakoulin@amd.com, 
 dri-devel@lists.freedesktop.org
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

Hi Satyajit,
That makes sense for the 8-bit normalization.  Thank you for testing
the patch on your equipment.

On Mon, Aug 10, 2026 at 12:05=E2=80=AFPM <edu042sjroy@proton.me> wrote:
>
> Hi Nathan,
>
> Thanks for catching the normalization issue.
>
> I initially used 8-bit normalization because the mode I was debugging was=
 3840x2160@60 YCbCr 4:4:4 at 8 bpc, and I incorrectly tied the CSC normaliz=
ation to the output link bit depth. Your 10-bit normalization is correct.
>
> I built and tested your first patch, "[PATCH 1/2] drm/amd/display: fix BT=
.2020 YCbCr limited output CSC matrix", on Navi33 / DCN 3.2.1 over HDMI to =
an LG CX with BT.2020/PQ HDR. The limited-range path works correctly with t=
he corrected matrix and fixes the incorrect HDR levels and color I was seei=
ng with the original matrix.
>
> I also confirmed that the resulting amdgpu module contains the corrected =
limited-range coefficients from that patch. My hardware testing was limited=
 to the DCN limited-range path.
>
> Tested-by: Satyajit Roy edu042sjroy@proton.me
>
> Thanks,
> Satyajit
