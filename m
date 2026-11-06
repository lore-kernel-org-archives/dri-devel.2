Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0FB606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u4DPa0fT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EFB10E47F;
	Fri,  6 Nov 2026 22:41:52 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D77010E2FE
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 22:41:46 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3b08a162d4bso656775a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 14:41:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794004906; cv=none;
 d=google.com; s=arc-20260327;
 b=eLBsZC25YK7hsyqLAcZmkKzQFexldXhVpL83gNBfH25i7f6aakZcnj4/RazO+z6EZ/
 pxAwI/cLq0HJB46goHNJ77joqEH6KTLt0MTZ8te9Mzq6e9eaPvgMqXsdwg3KCRSdWLlq
 MIMm/EP+0/erBI58s3/2YDPhzdGEFv3Ar4oki4poDKCeHHViCN5RPpdG+4Yq55m0qep6
 +EiFKIp6eacIfetUhtp7fS7i6TNGvICKvV+Sr2oOAHblhm9QiczfHbgLoLN5jRdHbHbK
 6+47lpZcAuuEa7cVNalWMYW1vsPkKBoR5eWQxdTtHa1qx9hZ/J1+KnEzIpR8eJrd4h5q
 ve0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xDdVmSgPWBsW29mq/W8l7c0d98Ur3czuYIjbAl/YHDU=;
 fh=92TbqfBZuQIu51O7l+v+wIFBkxmoCgvB+zNqNrdhnP4=;
 b=j8EeqiMmlBxe/PQw3IV4aN8OhWkOnVosQs3iz/qeAedy0HZDwBkXJAySuUWvyUvajw
 +5mC70CidUC0GVq/vdmKi5cwC8SstVvAmDtQ+PX/JmQe8dm1f97oeLXQLCfqzmNBKgqd
 oHs5JLCfO9o21MCKfAVafcZOeV8oquFEjn+QrYEgMeiaHbqxsFdeMsEA9t7/T/0xe0yo
 guJCN8Nv3g6GwlF4YCPiRpSoF+nMI5MKVbjPcMT3bZR0I+EhGTsdgPckQG9Pg31fTaQ2
 eWDhuXfXYaPHVv81WHqZByok+84Yq0BnYi05IdBRh9bFzv6Wq//xkUkAG8frGXzdqJNG
 LsDg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794004906; x=1794609706; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xDdVmSgPWBsW29mq/W8l7c0d98Ur3czuYIjbAl/YHDU=;
 b=u4DPa0fTsDVvWglCedmdLrH1YucpZy4K5Ji1A2u+EabJpxQnvXIiiS8XgeRNlVFsmb
 Y10Ne35uC6F1nPCEuDF3uV1S0OgGRXqG0K1iQOXJ7wVXGK9rtiBAALdstWQRtxE2Q0r+
 zVCsoTDo1qXn82B2Q4yYTe0tsxdUHSly6YuiVAAyJHRfG59JTECiPE3Q0dGlcOJAKvn8
 yvuW/cTZfQ/am1eCrckPnTxbnHmCfnYs7vP9tlzEDa517VFrLolWCzJp2JOGKy2RiCiM
 V4t0SSl/u9Yu1L0P3bFcp9s2ihIiAJ4knjdo8qWhg1qDwV2vTJnroPgcAc9bZ4XxKbRH
 1t2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794004906; x=1794609706;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xDdVmSgPWBsW29mq/W8l7c0d98Ur3czuYIjbAl/YHDU=;
 b=yhYJH2oRoy270iBYJ+ouiFTyFKn/Unb+jOKyxUMekaQE8rjRgfGPIQ4RmwxKQccEvD
 M1Gz5r2hD1hYRYTcJ+4oMwjU9cv3eZGfDn/PVGae0evGM+6Re4nCAHoc3T0VfAyeVEb3
 U6fsXiWB1QndTFvRqNLJZwPVI9CAD+YH8jCTa9UmsWNC14LQ+FUOdYxOm24aJKRv8aa8
 NauBBYiNKeCRYhWqXoRoIoTAxktivXc4EVrzSWO8LHzVo+4t1L9JPVhVjkWSqts/uKfy
 v8PcLN2YbnHf4M4Af4uPa/vgh04sqBM1GAW6LaSCpPY1YwtQZV4VFeGjAtp2KQFw+jN4
 G5qQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFlAFQ/Kv1dNSjYFer1/tDGCMPZ87JYEATHFFVA53fg1uZNaxknmv0n+jT6hrUJ4uLW+CZbHVr4dd8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+jXZY2C0zy7EEGVE97NY0ScmoAJ177IJ390wMOPqWpMAiPWi9K
 ZjnwNrve+dFJQXvpDl+Jig5SFZGoHcrZdv/yNmmsJk7YqsMGWpOOT7KuEqqrba90zLD6/f20skL
 +kPhDiMhkztW1/aF1ODOPzsrlcq6vOo8=
X-Gm-Gg: AYBFou1h3MDwy/gyFypDiY/XQ3qZBB7KsGT5EZuEB9Ar+DmIyBketpzvdtYLM99GSAT
 7exDWSEec8ERMbOK+rGPW73mMEHXOUIlmMKr9TJX/T6ug6qoWSlKchLkyxx+JIUQ0HEgcGPRbdE
 7iWH1c9Dy83tQw56N16fIgb7qWY/k/LAlRuSEDycC2wjOuWhHFYL1+Wb0h8/2QWJmYp6vCAz1Xa
 hwDEDa2gAQaeV3M27l4YZBXaUeZIXNH0asiGiFk74yTMU85RtjHdd6YYvnuJSRvnXJskVPqhYKY
 p7tW/QmfgZxwrB0V0bOO3TxheDYqFQnubQoMQEKbhqqpJe7fVB2DlfbLjxZUVX6/jo30heUa8RV
 lhj9z95k9yywOCNYOZ+rvRtd04MU2Vw2wpM61TtNboLUW5Y8L5leoyCnOA0SUVpnlkCHHVMU+Sh
 TMXtlV
X-Received: by 2002:a17:90b:180d:b0:3ad:93b4:718f with SMTP id
 98e67ed59e1d1-3b0db722366mr3867947a91.65.1794004905717; Fri, 06 Nov 2026
 14:41:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-fl2000-upstream-v1-0-bb163ecb2309@gmail.com>
 <20261105-fl2000-upstream-v1-4-bb163ecb2309@gmail.com>
 <8387cec8-cdb3-4854-9558-16b0802ebf5c@suse.de>
In-Reply-To: <8387cec8-cdb3-4854-9558-16b0802ebf5c@suse.de>
From: Angel Gabriel Crispin Valdivia <angelcrispinvaldivia@gmail.com>
Date: Fri, 6 Nov 2026 17:41:34 -0500
X-Gm-Features: AclHuK8n8lF66XuY82ir_ixNmmEcpG6vcGXhy2GuvV7QuQd3jCyvVB0XxXfb-yQ
Message-ID: <CAOFFMboCd4As6F5RRG=NDkSkDufjK7KwZxfbMhONVKqOGwF6Vg@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] drm/fl2000: Add KMS display pipeline
To: tzimmermann@suse.de
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
 simona@ffwll.ch, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thomas,

thank you for the review. I have applied all of it for v2 and tried it
on the adapter. One change has a cost that you should know about before
I send it, and the answers to your questions are below.

> I assume that XRGB2101010 is the hardware's native or preferred format?

It is not. The vendor's API has RGB888, RGB565 and RGB555, and the mode
bits I know of in the chip's control register are for 565, 555 and 332.
I have no datasheet, but nothing I have seen has a 10-bit mode. The
driver accepted the 10-bit formats and reduced them to 8 bits, because
Mutter renders in them.

v2 offers XRGB8888, converted to RGB888, and RGB565 as it is. I saw
RGB565 work at 1280x720 on HDMI and at 1024x768 on VGA.

Dropping the 10-bit formats has a visible cost here. With an amdgpu
laptop, kernel 7.2.11 and Mutter 51.1:

- With XRGB8888 and RGB565 only, gnome-shell logs "Zero-copy disabled
for /dev/dri/card2, import failed: drmModeAddFB2 failed (Invalid
argument) [...] format=0x30335241 (AR30)". mem_info_gtt_used went from
96 MB to 6251 of 6939 MB in under a minute on VGA at 1280x720, and was
at 1922 MB two minutes after boot on HDMI at 1920x1080. On an earlier
version of the driver, the same message was followed by a desktop
stall after about 30 minutes ("bind failed" in
amdgpu_dm_plane_helper_prepare_fb).
- With XRGB2101010 and ARGB2101010 accepted, there is no such message,
and GTT stays between 107 and 134 MB over 45 minutes.

This is Mutter's: issue #5101 reports its copy path leaking a framebuffer
per frame on a DisplayLink output. Its main branch already releases that
framebuffer, since 15 October, but no release has it yet, as 51.1 was
tagged on 12 October. So I plan to send v2 without these formats, as you
asked, and GNOME users will have this until the next Mutter release. Tell
me if you see it differently.

> How large a value could you write into the registers?

The register definitions I inherited from Artem Mygaiev's driver have
12-bit active and total fields, so 4095, and v2 takes its limits from
them instead of the number I had made up. I don't have the manual, and
reading back does not confirm it: these registers return all 32 bits as
written.

> Once that is up, do you receive interrupts? If so, it would better go
> after drm_mode_config_reset().

Yes. v2 only starts polling the interrupt endpoint after
drm_dev_register(), which also lets the state you asked to drop go away.

> I'm not quite sure what this does. It looks like it's code for the
> encoder/connector.

It makes the chip believe that a monitor is connected to its analog
sense input, whatever the input says. The driver keeps it set while HDMI
is driven, and clear on VGA, where it would hide the cable being
unplugged. The vendor driver only sets it while programming the HDMI
transmitter, and I have not tried that yet. It is in the encoder in v2.

> I think it's better to resume mode setting first before resuming
> hardware. Otherwise the incoming interrupt might run on a suspended
> pipeline. (Not sure about the resume logic.)

v2 starts the interrupts after drm_mode_config_helper_resume(), so no
event runs on a suspended pipeline. The chips are still set up before
it: the adapter may have lost power, the register caches have to be
dropped, and restoring the state writes to those registers. Tell me if
you would rather see it done differently.

Best regards,
Angel
