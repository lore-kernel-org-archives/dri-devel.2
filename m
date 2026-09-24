Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A53C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD27510F8E0;
	Fri, 25 Sep 2026 07:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rKDEBqnh";
	dkim-atps=neutral
Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com
 [74.125.228.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A3510E343
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 01:30:57 +0000 (UTC)
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6a99c5de614so2146187a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 18:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790213456; cv=none;
 d=google.com; s=arc-20260327;
 b=mQKsKn4Fb9Do5cUz8DoTYVJIkw3ZYXPZUFOByW0WrZ7TLb1cyIPNPS5CeAacNHxz6g
 KylQ8YtiSpkSaK8/Xi4tDpvnFPa212NV07Ij7hmLZYgN1H5zqfhNZsi9s6XiMuQWIXyX
 9KJj56HHK8+VaOPUXwXe24oPkUylRWeSb2n54iKNFweCXPR5/TtJn209T7BluqfcN6CV
 VoRi4jgNKB5W+1q9vVD6JWxZtLSzk/vymSMJJRQOJdA2DN67J6Vwir9aEDQcqFkffN7q
 EOZkFEoz0ETJEhPLMWu2liDs8VMwbwykl4vlDJsoRYcpElPsUDtaw7qZHCm3Qz93xGw8
 HWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=CnXT2kKWFtk+H+QoFRvKF8/DBZgKkxfd0I024vd28jg=;
 fh=I7Np53wqc4yHlUQn0+h334aAIAbmYYXHcibpXtxxeuI=;
 b=Vp7cETSTSmF8E/63TFQMYT2gyAPBDobMfEaaDhmDzqtyRmvnilDJG6ddRSRyHyZF/b
 1vpm9CZqf/rtuxvc3rGTTa2K4VbQ11V4nrhc8JbMZMZjFqTA4koPNLmoBMjTlbOuMdIr
 VMIgW5Gx6n7Z84SH25n3PNgZymxsNwEZuQrgkPuStAR+LLL+kI/gnBR2QRl7yGeh2OE+
 opEALLv7Kaic5i5xEQ1VGil3HNZf6UB9vRHPJsUDPR0SXE1P0wQnF2m/6/SHiHNONuz8
 +ODsK6uoGl6lp1SZQ4sECEQQhCpXgKguwZoMJRiL1Jlvz7Gw419V8GgvD9y1ABdZTk1v
 M3Vw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790213456; x=1790818256; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CnXT2kKWFtk+H+QoFRvKF8/DBZgKkxfd0I024vd28jg=;
 b=rKDEBqnhXujMFoecXb8CWEmlkGhQtQosQqcAxv9n8BLhTcGu/inb2Csypv+w19QXTg
 ZjD5Wt4pNwZZVP3KxoZXtcQHG1CuVst72hbSsSBYkiRCG6oEreZR4GCswdpzTCh6cdj1
 zbt3uT6wUY81WE0Tw1N+K5OIPlfZ4Wp2wNnG2Nw/RCFH/fGbjw9+IsQx+HrXMLJhq7Qf
 lvWkMPDo4m7Wx9mYAezDtxuTmPfa88QKSzs2TNO8FshHiCHPRqXlKzkceMNfSh92nO9q
 g1q+nMWew+2Btf41ZJFbCnc3e+OWOFnNM5zi+0qAEaabep3MBg9W4Z90OOsYWVkmyJ/u
 1MHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790213456; x=1790818256;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CnXT2kKWFtk+H+QoFRvKF8/DBZgKkxfd0I024vd28jg=;
 b=18EHneFIB1Dg6d2c5rnBeclsLvldrDIhVDWKFd4w9Tjg7hLe54fiRcZcPAShpD9H4K
 VqQtRAaH0wrTDdlrQUNdLs6k2eZU8NZf2rIF8dAVYLbnWpiKPdzAuo1aWeQiNp7+Vmye
 vFw9IBiZb2smcMImrWMgQOIltob5MPzBOzRaAKaPfFCbdy8Gnoc/cHN/O7PQ8AodkSBz
 g/iJTB1CAr1c84+fMjgVDGNhxGvp7zVBcyYxQNoT7mtpB/lif+6wwXJ0+Q/OmhqgCo89
 FT+iNzK/betJypd8jTL62NvFtv/3RyphBcyvnV1y1hvsepNSvI08FMAJL8Cd/m1iYFqm
 tCNA==
X-Gm-Message-State: AFuF++l0im7cdb07C9q2QfcTbv+8irkzdMwSlBv/pKEQVBpsBEwsk2Vb
 f684DzaBYiI7YKDGewkDXaBTBXecQ4LU1PulydOfYalG2iOumeIiKqtPrm3kzCaxTo+LT6rKsYk
 74dJbXgnXl0QnFjmc0ThI2IxYDKIYlMT6gu/BRBo=
X-Gm-Gg: AYBFou026ZH7jV2iiPu/d3mU/Fkyi1axXgSiasHFjIz/qOERY73RH+jLPDVR8rFvizq
 uGuutd7zi+VRpnZOIAkmKO+PU/2z78j+ik8wANyMBZSeZZaHo8UDmDzzgK+VrkO9/QzWH0U26UF
 ib1tt/yALfQY0HFp1IlLXVn+wMQuQNS38mIt0Gl7H+2yEgCq6ELz2/DD5MWQ+63NLnZ3Rm+KjEc
 cYxQY/y73GkgpZBfmqlYGULHJuC+rlm47epVg35BDQsmRaE0AQBGZ5HWEgW78WJNe/DSEz+nb+W
 KbNHAbno1Jq0w8VfcR1jkG1s1yC/BBj2n3qSytDPP23Pr5POfEBK3XuXb1DGXlfrohHGPAJfhVx
 b5WiCklAbGceioPsed4jpPujLUuU1GQJlviR63V66/vqjWSbKwP586BKEo1T4bMMCm+A=
X-Received: by 2002:a05:6402:5415:b0:6aa:734b:1a1f with SMTP id
 4fb4d7f45d1cf-6aac8f4af17mr757223a12.25.1790213455566; Wed, 23 Sep 2026
 18:30:55 -0700 (PDT)
MIME-Version: 1.0
From: Liang Tang <liang.xjtu@gmail.com>
Date: Wed, 23 Sep 2026 21:30:42 -0400
X-Gm-Features: AclHuK_3a37TtXWF_WcjLVB2jN1wtpcBGwa9tsJh-yvHYX-pNsSohP9OCHA7I70
Message-ID: <CAGQVUc7O8w9RpVyXNRVa9xFf0ArLboP8dGwaVe1ppJ1hjU1Qew@mail.gmail.com>
Subject: drm/fsl-dcu: question about open-coding drm_simple_encoder_init()
To: tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000175a40065c308db9"
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

--000000000000175a40065c308db9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Thomas,

I=E2=80=99m interested in contributing to the DRM subsystem and would like =
to work
on the TODO item for open-coding drm_simple_encoder_init().

The current drm-misc-next tree still contains a call in
drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c. I=E2=80=99m considering a small,
behavior-preserving conversion to drm_encoder_init().

Before proceeding, could you please let me know whether this is an
appropriate target and whether anyone is already working on it?

Thank you for your time and guidance.

Best regards,
Liang Tang

--000000000000175a40065c308db9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hello Thomas,</p><p><span style=3D"background-color:tra=
nsparent">I=E2=80=99m interested in contributing to the DRM subsystem and w=
ould like to work on the TODO item for open-coding </span><code dir=3D"ltr"=
 style=3D"background-color:transparent">drm_simple_encoder_init()</code><sp=
an style=3D"background-color:transparent">.</span></p><p>The current <code =
dir=3D"ltr">drm-misc-next</code> tree still contains a call in <code dir=3D=
"ltr">drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c</code>. I=E2=80=99m conside=
ring a small, behavior-preserving conversion to <code dir=3D"ltr">drm_encod=
er_init()</code>.</p><p>Before proceeding, could you please let me know whe=
ther this is an appropriate target and whether anyone is already working on=
 it?</p><p>Thank you for your time and guidance.</p><p>Best regards,<br>Lia=
ng Tang</p></div>

--000000000000175a40065c308db9--
