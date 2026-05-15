Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E0BCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 12:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0433A10F515;
	Fri, 15 May 2026 12:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="G0kVlfhy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HUUxaEr6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CABE510F515
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:30 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FB1qpp3670906
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=mNVZHM0vaurUkrmXeKukxyvOImFgIrlQCkN
 FvjRNZcI=; b=G0kVlfhyY2obMrR3HkjqumwaD28g+4iaT9Nv0FC1yqQmymYXDac
 54JFDhVgmkPjZ8J6NgyuPJBog41YPfXH6ik6oMQwcVYwxKLhJflF+lWfUhgbNekB
 CYZDG8ms356a9YjRxXTWBLnkfeXw6mNCiSbiRAiJND+fq6x2sSD7XO7dpu5Ipywc
 32lU5cq4GMlGdFH36igqoQmUSVG8bfKFgoz1s6cPyrcU9TzTHDDNQo9neG289NPa
 yoxokS5USGbls29t5pBYqLsG6cfYTOXAPn0oQ+qilvdhiV5T1Z38Av/ZMlLVDIbZ
 +4sYi6OX8JTggvOoTuW42QPgXbDDEvHjkkg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s3at3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2baf7748d0aso84747725ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778848950; x=1779453750;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mNVZHM0vaurUkrmXeKukxyvOImFgIrlQCkNFvjRNZcI=;
 b=HUUxaEr6hXElMVkKER3nezGAVvf9ptUab9xTHWEokoMWBxemO6yJA4+bYoDM7QBZLo
 EqcziT8eRabF3+unsqutobTFI5PEsVbmUWl6B5JW8Qgnyf4U4Xp6w+71LUmGxCYb30uQ
 EaUx0RLxqNC3TiHOs07TPSozmFq+8JiukMU4x0mbfBxSrEAOeCry7iV5T/psPJeEOxQr
 qSPGlsM10p9y/HR9/H4numn6No3vMrFet5tNZCi0Wewx9icFX0mgu+o+D45p9vJUjzO0
 Xns0PRhkHgN4qR1FBlXyIibPCKfAcdlgiBgVWL6teHtMKAB1M3790RcP4iVyvi696orZ
 3nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778848950; x=1779453750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNVZHM0vaurUkrmXeKukxyvOImFgIrlQCkNFvjRNZcI=;
 b=ewpqsh1yoNahcN54YW1V+BdPHIvtQ785l/ocoRaWPrpVZqGRIL6NgGVVaokBjc7Z2s
 rp4j1LRcWdZfuco2Rzu+8nm+Duy8PqcGgvT4kIlHWaGzA77EgWGhyX4nMSGEdB5+iToG
 PkRtTxykoiEBNtsCC8BEti14rLGeAFiWXkW7ztgct1jBS5KpdpTZDMQsmulGCqC66VBI
 w8cTN76AxbgsMwhoAVOL5Hc7mgtyMM1gVb+oB2X/+0JWKcelzX6nZA8Zzn5dCK1LDih5
 LgGHKQ87VYvcQuKObrNOatLz/CswShah6DBAVk7WLJsajyWZUK6/8ICSTrfUgC2FDpSS
 Bzbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/X8kE5VpEBxx68Bam2nmz7jgQ7WD0hOBJONALBLhw4dwNyTbF5RKwF0lgx5fti43FnwdNINVMI53E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxASJHsRGuQnDRSDkoYiAurSG644TmsP/PQcE22SzrQh6E7vL9J
 NVAhRKgjUNBPmJ/BqlyCuZ1xa4/QlJFvGkVFFwsyZCQoFazoJg/nXDSAKNONgVnGVNEbHkgly3f
 4CDtsrNfQrqD8cY3Jj/q8pOADG4FyWARjbrNYZFBw4eGUdpN0BhJQCTOW21dKtssg8r04xoc=
X-Gm-Gg: Acq92OFvChnst7fB6iouwUggEwGekYQykt3rupMzD2dw+dSketeSaEN6PDFt/i6vYB6
 RKBxfGWsYp5QzeaiMdM5ivwAn051yWmw7TFLonJWjqjtshmNYTx5JRmCj5BukkT/OhJNKoo1DkH
 iuOMms07Xdey+fZAECzJDLcMvrBwgYo1SkAj1XLz8S9R/hV8zM6TbWpmXA9rEfC+C/xNUDCo624
 ONIQWGaN7mnjQnEmogmqQtHSqMWtfBho7WrwvnReC0va35E3E9sFCVrwzP37yX+0dHfyYuNJsiE
 2U/c6WnLayvGX1DRMsoJrz4qmJXwo8UFnkmwfJdNe3giaYsU6RPsELbtWX5IstSwXTkrhOdXGoH
 Ps0IteOy6nlpnER6vND57i0S/JQ7ngK4COOxqCcus3PVTKs4lAgxiGtlPYJmsVf/MW+Dgu5Z3hL
 xNpxXo37ePoHxRpRLddRk=
X-Received: by 2002:a17:903:3c28:b0:2ba:bfb5:9cc with SMTP id
 d9443c01a7336-2bd7e8d3b9fmr45081985ad.26.1778848949214; 
 Fri, 15 May 2026 05:42:29 -0700 (PDT)
X-Received: by 2002:a17:903:3c28:b0:2ba:bfb5:9cc with SMTP id
 d9443c01a7336-2bd7e8d3b9fmr45081585ad.26.1778848948761; 
 Fri, 15 May 2026 05:42:28 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05f27csm56119395ad.25.2026.05.15.05.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 05:42:28 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ekansh.gupta@oss.qualcomm.com, quic_chennak@quicinc.com
Subject: [PATCH v5 0/5] misc: fastrpc: Add missing bug fixes
Date: Fri, 15 May 2026 20:42:12 +0800
Message-Id: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyOSBTYWx0ZWRfX+twkMgMJ5J2w
 zfvzaFEpNxS5jXQL2W8daLcPVl+wA95WwntsYJSE4S5xa0zpGLyP3dzZNFUuD4xw1eZpuuCICrI
 DQbaB2bgfGslaVaVhgnECX4FrhgGFBBhVSfi83eXODx1yIrDFTgZLtlMVvP5K8YN/bpKgl8y6XJ
 MpbenLQ2HIkuI302PLidMBpP2CU+64dV6V2MnP2dfkAWwGwitRfSToTnz/MNGZdRLIt04vggylN
 6NLpLCH/U3Ze8zkb7GMuA+4xrImYx4I30jJS3OcndYEK6lP1+umJiNMiGS7VRw0uPFfueE0ReDx
 dkXdHZepjXB14TWn72l1e9EVosTs5ZqrVptlRfMC2T6Vjtgb5nOiXftUUsJ0SRDh6eYanG7/MU1
 +Om/VFT8Vu93sPO74VY/3MKCufJhY60CndHDdkGRrNlw8+OtzTbUtR/Ztft4BnSbnut0fKXR7mz
 g2NxA5YSbP47823hS4A==
X-Authority-Analysis: v=2.4 cv=Md5cfZ/f c=1 sm=1 tr=0 ts=6a0714b6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=mSfM1xQJxAVIrMv2y48A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: -9YzSpyfQA8ApoIBtLujy4ndDeCFpAVk
X-Proofpoint-ORIG-GUID: -9YzSpyfQA8ApoIBtLujy4ndDeCFpAVk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150129
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

Add missing bug fixes in memory areas. This patch series fixes multiple memory
handling issues in the FastRPC driver, primarily around the Audio PD remote heap.

The Audio PD uses a reserved memory-region that is shared between HLOS
and the DSP. Allocating and freeing this memory from userspace is unsafe,
as the kernel cannot reliably determine when the DSP has finished using
the buffers.

To address this, the entire reserved memory-region for the Audio PD is
now fully assigned to the DSP during remoteproc boot-up, and its lifetime
is tied to the rpmsg channel.

Patch [v4]: https://lore.kernel.org/all/20260409062617.1182-1-jianping.li@oss.qualcomm.com/

Change in v5:
  - Split reserved-memory handling into separate patches

Change in v4:
  - Fail Audio PD static process creation when no reserved memory-region
    is present, instead of silently proceeding

Change in v3:
  - Adjusted the order of the series, placing NULL check changes that are not bug fixes at the end
  - Modified the commit message to describe the bug background in detail
  - Switch buf->list_lock back to fl->lock
  - Add locking to the operation of audio_init_mem

Changes in v2:
  - Remove the if check outside fastrpc_buf_free
  - Store the spinlock pointer in the struct fastrpc_buf instead
  - Allocate entire reserved memory to audio PD through remote heap

Ekansh Gupta (3):
  misc: fastrpc: Fix initial memory allocation for Audio PD memory pool
  misc: fastrpc: Remove buffer from list prior to unmap operation
  misc: fastrpc: Allow fastrpc_buf_free() to accept NULL

Jianping Li (2):
  misc: fastrpc: Fail Audio PD init when reserved memory is missing
  misc: fastrpc: Allocate entire reserved memory for Audio PD in probe

 drivers/misc/fastrpc.c | 135 ++++++++++++++++++++++-------------------
 1 file changed, 71 insertions(+), 64 deletions(-)

-- 
2.43.0

