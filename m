Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5208CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 05:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57BB410F1FF;
	Thu, 21 May 2026 05:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dpTzfy0M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MERXN9XX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F7EC10F1FF
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:45:59 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L1Ii0b2072131
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tFUu7w/Mdhl
 BRhU4Ur6TRUhTba4EbTByy053HqbjsgU=; b=dpTzfy0MDrYxCzoOjM4DFdgB0Ed
 1h2kkQrHkhtDaZ7aHB/xRq7sNFWYXp3yZM9GAvrIi1PIIJBtzu3gNcNyMb3ynrRW
 dSlGwiNQki5fuw3PeQIeghZZg2OkI2w5nyFiB9gCOEcstRAVhm9miNYrLzI4gzOn
 EW+7vj4kQ1RkctB4Q1o21CJOXp6Ewj1a8QkrT9xEKztNQls5XAVpJAzDV0vipZ7V
 8FwhobQs4Jp+IqDYND1fObtmGQhUMIMNJ7AhuRgZQJHA1yt8nVzcN9jO8qM6GPRe
 oCyImXXMCBKywCDa7IVvY5X8yI63R2rGvXgw98FLvJvZsOE+DT+JUzSGWvg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9r960tk5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:45:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-367bb9caa54so5131974a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 22:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779342357; x=1779947157;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFUu7w/MdhlBRhU4Ur6TRUhTba4EbTByy053HqbjsgU=;
 b=MERXN9XXCrRL1K7TJIailtz3acQF13wqEM0hyV92Bw0+6w/PTb2OsCYuYW9szIbmk0
 UPhzECaevQm2MLL2WJjRd9UZCBnkKPmPaqXgniY6mRibtdhTJRx6peQdU/jsX9YPNWe5
 oBVcK91CwjgASNi4fbBFDc0aoKsU9tY3rbsjA2iJ3alwrYCHiSnHH3s3qr0kkd1g6nZR
 qdqJhpZ/oTzN8ifQ018ALDIlsJq6Cd+z8MKVHhDhcvl90K0rxtjFTMm+2ALJyIRl0YyR
 DgLDff6DADjS2lzGcfntUUzC5FjXAT8rHRWqCA6JLZUBeLz/saUuJZY5CWq5eFwmuG5l
 J9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779342357; x=1779947157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tFUu7w/MdhlBRhU4Ur6TRUhTba4EbTByy053HqbjsgU=;
 b=HBnUiK/t7Cg2E+xEmlqeNmqZ0f5YKMMYEFhEvC/Vg+eFxM+bqdA63IbjnjVk9mvSiP
 vDIjioSR1TDsoQ5dDX7p34Wbx4UCnmXNLB+rSTe/QxY6XAKE5Gu2IgsoFxP/3IRRW0bI
 Ae2T+w0KL+R3JeV5zEhTEOOGmejqxaqAsenjgNqYBMVt7Lk3VxOYK8M+JKNgTbyljAVA
 ETdSnRWD0tfLc8e59ry3zN0fuB3306v0r6yoaEH7z4U5uzK2XDYqFggY8Ye9YTTuhUYj
 GEO1wiJpmcWle7uA6PkMN38oZ/hbZ9FTDIamhVSw0X6tWilposO87aYDWHmxZPZh7RaO
 J2Ww==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zyVYJ3yhCuhpJYzEdIZbMifuGQwtN1TG3OiWaRqpxUaDNGEbpidUbhyCE4C+xRQRcN7ceq/TI8J4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwA6BJfPdZNrNiqz9RXbSvpdaJrhfIaOS/obfER00AyOGY6lMpM
 1iNn9maYlN+Z/u37eXwIVthi9PWlyBfTyW+DoVqyUPqvM0DhA2G2YaX0e43o0+9Hl79ghu6alit
 Acl1JEPRYxGFVdGiIAQqRGCc4V4MAaYEQOSA/0tQynz1MSZ4H81MusFiVcrSmnhDyjQaSSx3XjP
 lJPUM=
X-Gm-Gg: Acq92OGkrnjh3xZJ+bbFa2oRyIJ3bA0ppfSJKi8VOMMjFF9MHJbKYyxPSoAjftwHy3C
 JrVOctmxQc5IoaVZVHX2k9h2R1awLTBEl/6cPpra2svRhfbHimizJjoNolmnf6HyCrpGd6End7S
 52stmAO6kMNMzDKyQ6WTJSZr2OFJv7JG8auZ4qCGnb5aPgHB/rG8kg4t89ePtrq/rf/bHgfHQxr
 mEAlOvJ07LPctRXI+sg8cUEqAY1y1gB5oUoQGHh412hY4YZ4/AaM1eOtiVgsX5CVrufC67v4YN+
 EFo3bbz7tDv+uIf2HJffXzDZmRiDjgQcm5Ezms/ZdbM2k5OjrbQYECXUx9n5R+MEatyJFcy4eUx
 8TuSciBfCHOuJmF/IGJASY7NBClNehvTJJQg1grFJH99KLrFUgcZuYw==
X-Received: by 2002:a17:90a:dfce:b0:369:a962:8cc1 with SMTP id
 98e67ed59e1d1-36a45130fadmr1415885a91.2.1779342356666; 
 Wed, 20 May 2026 22:45:56 -0700 (PDT)
X-Received: by 2002:a17:90a:dfce:b0:369:a962:8cc1 with SMTP id
 98e67ed59e1d1-36a45130fadmr1415857a91.2.1779342356200; 
 Wed, 20 May 2026 22:45:56 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3cb323e3sm1474847a91.4.2026.05.20.22.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 22:45:55 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v12 3/4] misc: fastrpc: Expand context ID mask for DSP polling
 mode support
Date: Thu, 21 May 2026 11:15:38 +0530
Message-Id: <20260521054539.128651-4-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521054539.128651-1-ekansh.gupta@oss.qualcomm.com>
References: <20260521054539.128651-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EnYK_XJ3ZF4tYBEjiyIKgVHCvP02tJIx
X-Proofpoint-GUID: EnYK_XJ3ZF4tYBEjiyIKgVHCvP02tJIx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA1MiBTYWx0ZWRfXxvDpVDvlOjOS
 GlNWpOV7y5dJ4kg6OPkeoi13JKJ+/KQfKu5e+2SPLMZQOQRqKSN6froXt/50J67XWFtqbGA2mgK
 sSF5y/0ydrRVQWK2jibFKC1Lh01/uButln8MKwoIzwt8VO2BmH4CsO0ECVdzHy5n0w80yVXT/lL
 Ox90/CGradP+AfeYxWiHbdva0cxAqObTW5+EGOJi6qQO0NS3xucpL+TiHWXfX7oHzemzDDii2Fj
 PdT3DMVcK492D2YutMG6kWunZtScIf63UEfXSDxsA+edOlJinvJu/xUv7gXZ8KTHm7DsTFu7A/2
 CAa8zPhVYMMceD6IxALMM2roQANdNx77MVh4ebVoOCj39QfGa7f05iSJkp+PpEIvtRIcOIYT7RO
 774dDFzkvA2H0nmnwe+3saVS1bx8p5SOOaxFHlBP7uQiTs8Qk4HA5QJa3DXRVSva5dm1qLXShlJ
 /EuG/psIfs3Z5DVA8+w==
X-Authority-Analysis: v=2.4 cv=GqFyPE1C c=1 sm=1 tr=0 ts=6a0e9c16 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=JTa3dIKMUYn8LlmgGFYA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210052
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

Current FastRPC context uses a 12-bit mask:
  [ID(8 bits)][PD type(4 bits)] = GENMASK(11, 4)

This works for normal calls but fails for DSP polling mode.
Polling mode expects a 16-bit layout:
  [15:8] = context ID (8 bits)
  [7:5]  = reserved
  [4]    = async mode bit
  [3:0]  = PD type (4 bits)

If async bit (bit 4) is set, DSP disables polling. With current
mask, odd IDs can set this bit, causing DSP to skip poll updates.

Update FASTRPC_CTXID_MASK to GENMASK(15, 8) so IDs occupy upper
byte and lower byte is left for DSP flags and PD type.

Reserved bits remain unused. This change is compatible with
polling mode and does not break non-polling behavior.

Bit layout:
  [15:8] = CCCCCCCC (context ID)
  [7:5]  = xxx (reserved)
  [4]    = A (async mode)
  [3:0]  = PPPP (PD type)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 3f5d5d73be5a..c4a3547a5c7f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -38,7 +38,7 @@
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
-#define FASTRPC_CTXID_MASK GENMASK(11, 4)
+#define FASTRPC_CTXID_MASK GENMASK(15, 8)
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
 #define INIT_FILE_NAMELEN_MAX (128)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
-- 
2.34.1

