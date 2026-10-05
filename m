Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1792CA5FF5
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 20:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54CDA10E1B0;
	Mon,  5 Oct 2026 20:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="MdgN8Yuy";
	dkim-atps=neutral
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B2510E154
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 20:15:21 +0000 (UTC)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-ccce967aa8dso694727a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 13:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231321; x=1791836121;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PsxZfXvHhjPTT7xVmNsmNg17aOdYlA6JQ4QoJ8wnTfo=;
 b=iV8903XUMtllKEgnK1f6a6vlCweQ+2cEiCkfnUkKCQEnbsDdD/dw4+Lb3fPeR0U4wC
 jeRwEuaXv86aY14kaqPmE8bxs9eaZLdAFUDzcOvA94VFOm7dRVpIX5wn6YVvVzrxtflh
 KfYLGUQqlXACnfPHXh90XCxKRkXIO6bx5QRyfhsjI/RnaKbRY76DO36f/CpSTz7NV2ze
 qC3y8tbFIur7qpepet9kHROyJZWuqKotc31oDeR6jdOyOPuhuFvtE4WN9Y3Yd9NFEq0x
 70PuKfmknaaODcRHR8SWYL5LTc2jkRsD/zKZlyG/zCdhtaPyIo0iY4uOfm1Tac5xam3Q
 Av4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVNDTFA463eIdyz30qTm7pAdwR0AlZjZfV/mtZlWosmmHgetm3XoVSX/PQTfsPZrgZAirhGCuNIf8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKS8s9eqAEhG2djiu4sukYsk95zgW0e9MAlL8RCfqNE2GIcHFBq
 b0h4T3ygC9tZ2A76wtwhPy2SugNiFCJJV311ptUn403zu/WfhrSds8W5r+QOEdkRNRT+NZfdSwt
 7VG71K036aANSnFQFTbd1XNnwmyuioJcoPpQoKHRbKlhfiio+CJHVb/xqWZvM6t4mN1UeVYextW
 z6q8Ja3HUnR6xjpoo/bypS1NFhSzd6kCIuRzJghTHMhCrKwon8Dgq1UWuJHimB6CHh+YWtb2O4Z
 wvtcPAVeUy00lKDcqdEZ9XxINnY
X-Gm-Gg: AYBFou2uLxdbgRXGZYaAbIZlb1AW3DXHLub6rrHuKjN/THd8QnWJAmRh14AHBveax/U
 CUh3Rubyl+PngJ7mk4qxhCq0MBXd6zKWMY46rTuiOGyqsFFOip9eaurUzmY/PCH+DOB6ksuDMsM
 Uv68py0p6lWUGdr/oO1yoFQF8JgtwOqVDSoTi1AY1reMw4wCzBvMvgBFlkyyDZQHQAQTPE04aBp
 yXN/QVIzzEtuvlXWwH4iA71dLnvndajoLI3W2GW0Al0SpgO4YuJXZ1yeNpfg8SIfP92s5L7OIGr
 kefzJ0Px2+5Gw7D0YKkqaePoEkN1FOKhU/7/fFiOJ6lUcCuMShX7lZiT8rcAjAOKVy2qw/5mZnk
 KPkjlVztxj2N9Xx3xNzXeVaKEYXAuloK+IqxVfN5cz8ZcaPNdtYJvVxN8LsGNXkpT+9rK0kyrXW
 fsW0M64TjzOFP1SUpmR1oLdp+ICyUwOJeXCt1wYRo1vfQ=
X-Received: by 2002:a17:90b:3946:b0:3a7:ce3b:5554 with SMTP id
 98e67ed59e1d1-3a7ce3b5573mr4846694a91.1.1791231320453; 
 Mon, 05 Oct 2026 13:15:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-ccb71bbc585sm1839791a12.1.2026.10.05.13.15.19
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 13:15:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso465132685a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791231319; x=1791836119;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PsxZfXvHhjPTT7xVmNsmNg17aOdYlA6JQ4QoJ8wnTfo=;
 b=MdgN8YuyJskv/SkoVsPe8kf+3ZV7YPCC90zcxLvRAG6/5X9EqTTe4wvf7zAUMBOQ8a
 giYSpieVGah+xxMYIgEH+ajQMQtBgnzQOy4FqKW0QfWzTuYZtguIINbtE9ptP1WxeDVy
 m/Cp07ldHCNHDBo+X2DX2cc2BXFI1FoErvr9M=
X-Forwarded-Encrypted: i=1;
 AKwUvBx0IMmuWDDohwEH+cGD4QbKFOi0ZNpwv8XFdttYwqAKE4cio4WWOu5o1yZ4ScNQN2nF0TU+Bp6zmd4=@lists.freedesktop.org
X-Received: by 2002:a05:620a:4413:b0:93b:fb3c:2d09 with SMTP id
 af79cd13be357-93e510fc7admr1406612485a.66.1791231319057; 
 Mon, 05 Oct 2026 13:15:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4413:b0:93b:fb3c:2d09 with SMTP id
 af79cd13be357-93e510fc7admr1406606785a.66.1791231318460; 
 Mon, 05 Oct 2026 13:15:18 -0700 (PDT)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca2c96f4sm949911185a.43.2026.10.05.13.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 13:15:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 13:16:18 -0700
Message-Id: <DLX6J39ZERYJ.377I7R20BGISX@broadcom.com>
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>, <zack.rusin@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>,
 <dri-devel@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: do not hand the embedded sg_table to the
 PRIME core
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
X-Mailer: aerc 0.17.0
References: <DLUS51Y9OLMS.UQR4UY71TFUP@broadcom.com>
 <20261003163851.2257947-1-qwe.aldo@gmail.com>
In-Reply-To: <20261003163851.2257947-1-qwe.aldo@gmail.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

Hi,
I see you are using qemu for virtualization. That is not something we test =
and
support, can you recreate this bug and do the fix on vmware workstation
instead?
Also please do an igt run to make sure there are no regressions with your f=
ix.

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

