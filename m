Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E5AC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D70810E1E4;
	Mon, 20 Jul 2026 14:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="rBVPRbgy";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D995910E1E4
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:12:16 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDrFoi2987752; Mon, 20 Jul 2026 15:12:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=J
 bxx8hw4Eo4sD7QV5xyetGYbpf3+ILqg7Hfp4NhHhtQ=; b=rBVPRbgyvum21AU7g
 5yenIrsDml/ISEyhWhGBcSyiwukNQKfbSqXlG2/YMZpSwoAbfq9Un3v9wM18lAri
 GWkXRTtrjLeIzqjhMGCBTgBSGBkvGJ6AbrW+6DD+wyzK831X3BP+dWU6+tvyYzHD
 JDv3XyGUsjM54vdazi8sMHp4DbKaKWh1T6aUBleaUsZUH8418xt0Us0Lr9j1JQRS
 Kq66xAnUGLyJc1E8NrrPogqWvxQDoSI1XONgnRLt/JC7bXhPltXIv1z/YwhTa36i
 9knLx2tE7QqT3VsutkLndw1z1QxrA/9tY1HuTL4WlZeVlr/zX/aHmLa/a1oSZj7o
 3xj4w==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fhmy1g0dh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 15:12:02 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.9) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 20 Jul
 2026 15:12:00 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
CC: Alessio Belle <Alessio.Belle@imgtec.com>, Brajesh Gupta
 <Brajesh.Gupta@imgtec.com>, Brendan King <Brendan.King@imgtec.com>, "Danilo
 Krummrich" <dakr@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 Icenowy Zheng <uwu@icenowy.me>, <stable@vger.kernel.org>
In-Reply-To: <20260714073641.1935075-1-zhengxingda@iscas.ac.cn>
References: <20260714073641.1935075-1-zhengxingda@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/imagination: acquire vm_ctx->lock before
 mapping memory to GPU VM
Message-ID: <178455672087.464601.4204532217928591036.b4-ty@imgtec.com>
Date: Mon, 20 Jul 2026 15:12:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.4.9]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1OCBTYWx0ZWRfX0OAw3oYPc5Rw
 43IRIIoaT6rO9wms/dfXv+j2CX2pi/VVE+c5ClFU4T/1u/lEn0AxMVkE6bEhZkJbBc3PcLCC4H/
 z23cUH4xYsGBqHqiw9MGtGx4Zv5z3ow58Fil+HfxXqr37KbIjrl+hx065NVzI7bCtPh4X6rRVRo
 wjbaXzyRVuQqJ1oXaN8hBugC79xNqbFUWo/MJDvowj7arvAGf0HiIpx/Sh8cX6CZsSN+JI9Mgs0
 gIUxnAn0VQwVJMhTwNg1xNaCrxTkNtiTVDgkj9AKNWR2AzZdk/ghdXPeDcjZ9OLol4QkB/L57d+
 LbcwUDbZPowvu/mr198ywD+OU08kLPTHdpQaQRkPgJt5ELpGvvaoVeUAe08rn7DTserWol7Hu7l
 9lM8JhU68DmPOS3bRWNxvIu8o4DuedyKjyFI1+86VvEYKiJs7F0vJ45JdRJ728GYwvIQHsYaqZb
 lNoIQzSX8UAmEi0V1SQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1OCBTYWx0ZWRfX0rAX/3VGIXfv
 gL8LFonlzDnneeTTA03+AeU7srtKmQh6AUbEnqxPzrsZiXFvU+CMxmOfzBVfgz/tglO/vBAbQPF
 65IaaHpS4QPunKxgKlddsVhHo9RvTC0=
X-Proofpoint-GUID: ExdzClEsO37VXwoQp_rL_7X6g2QWAxFv
X-Authority-Analysis: v=2.4 cv=YIevDxGx c=1 sm=1 tr=0 ts=6a5e2cb2 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=rvaOABGgyOwA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=CNkhBcH9ogg0Ut-P5gEA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: ExdzClEsO37VXwoQp_rL_7X6g2QWAxFv
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

On Tue, 14 Jul 2026 15:36:41 +0800, Icenowy Zheng wrote:
> The drm gpuvm code doesn't protect find operation against map operation,
> and the driver needs to ensure a map operation shouldn't happen when a
> find operation is in progress.
> 
> In some cases a find operation will be in progress when doing map/unmap
> operations, and the find operation will do a NULL pointer deference.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/1] drm/imagination: acquire vm_ctx->lock before mapping memory to GPU VM
      commit: 17e2030f37600994440f875dc410615d5c66ee6d

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

