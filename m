Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5239BC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B57EA10E296;
	Wed, 26 Aug 2026 13:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CpcD0B2l";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dnyJhy97";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B21710E296
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:26:05 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCCFWL882035
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=bB/Mx69oBZb+rLa8duMgJQ
 gKK4MnuS8x8VisngUjkTE=; b=CpcD0B2l5a/wd5kyDMUKF4KqONW+t+0nSvMDHZ
 tHf1HdGBwJWRsnW55q6mcE6Fige79B5q+JBdTZlEZ9jreqMJeBPwOEpGgl9pTddY
 Kxv2cMwPuITfYZwinGdcbHDf3ksekNhWi8gUfAmvEOiFcm/ShJRHd9HlhRkGF1nF
 ZQzKs8dGgku3137CG9hj36vVZPQGOKPnNlbJcrRcZWvWV0AA1oi+M/CIwccDjjAw
 +RT5xIiqMrXK7aFDot2KAD3GLP1G4HI0BYC8neit5cSTxMyhNGeqkoy1F6O+h7RF
 2u8+2lAseN+36R6Ttp1Pqh4Ihx0SS1x0LBehbrmNuFsKK8gw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k2ann-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:26:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dde0df80bso1390500a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787750764; x=1788355564;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bB/Mx69oBZb+rLa8duMgJQgKK4MnuS8x8VisngUjkTE=;
 b=dnyJhy970KUvKha4iDbjW72odJQQjcx3BSXnxHYWHnk+s+rBk6S3OclIIT6Tf1j5YD
 xshXMB8uicKvlBapss/61wmcWFM11tZ2jsU00mOj4NR9+NCvQF9zZ3l4er2tOeia+VRx
 Utm6G+sRnBWvw1EJGZDf4axRYdNtfEEpr5eSYlXIenKvIYpNSHcR82ad9Wsz8UR/dPV4
 Mw4JAlBCFV3fQh+BTNOEB67KSsiDvrdRJ86FgXI+UTZD/0Mm8RSefmLb5lkRfUGYBL/j
 de8gu60Hzb5Z/P1bz9oYmHYAiruFfIQXFjeqPheRUaZL7cWFrVCplzf03IxmAAOO0rut
 hnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787750764; x=1788355564;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bB/Mx69oBZb+rLa8duMgJQgKK4MnuS8x8VisngUjkTE=;
 b=Mjl1Cc8RUqtfAKqBOkTnFC+SnZu/yYunlJ0KkQE9I+PlEu2f5+mCBtXLtqa2AB5Kgr
 mlnGgwbq7pLWf8G7GXYqHRy3e/BOwGfUDwZnSE+SD55TFZhTNtY144JAnoCibrh17JUu
 zWTu/fLNw80H7tSBFrtMWE4epS/8O/dSrg0/xu4bQo+vO7KUJCiFMd0V4IMYQctpHwTZ
 t+9YKs0jitYGoh7vwtMJgyMBgn7EeVCtzE4js6D2fz/cKvsDGjo+UhcxcfgVBjyX2nmV
 iAoednfK8s9VEo7CJPon9t8RzTwTvPnb2w+T8I2ePQ5TVoRAtlJwS0TnFNNz29OPubMK
 22dg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0gaVR7BVi2H3A7CMd3R/bWAdhKA9raPyytuaXyiYEuVg5bhpWTCcifmNUEyAiQ8H8KM4CTG/p83M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nLpGQnpRpGiZbI6XaIIJTQobujWKYDZUbjkQ8ferFqE8SFs29C
 /KvfKzTgFbigTlrp07LQytDAMUhH5AvLjCgVQCGCCAGLlGjMqXXXuZV+tOHB0D+UgcFTOysX1nM
 O4w0MDN9f4yUGeafl1ed+ScqLwK0I9fOENeUl1XgK+v38GO2NSv+d8JvXWs02Mp7jBGiSo5Y=
X-Gm-Gg: AR+sD13oCMenfruM+MNC8kLQdF7iV2UMKaLxnL5gpmQLIkcO3JnkSwmyi+I+8mf0pan
 cAoqUbLk14Hv3EVcIE8SchelrwkqelCcdGcTE/c447pQhu3Pwz909C+udNHo336dPc/CkT2OiqM
 VzuXeTVHny+saHOGCPA4z+Xj1OMhErebBnmZceX0higrX1PV2xPKKKWfUQg7J9o5bhSgr+ixCR3
 pIYB3s9Om4MJ6LcTN/OvdYrZ8Xxb/y3bhLXDQlLWhLpTp7UKkGUSpuAkfOhoSvrWawms5D/n2oP
 B6Z7YhlMvxv8OCsdV4EZ/UyFILqbJwIGQ3kw5At+UZGtJsT++ZcupELuKVAHxbPe7iizgGwbcY4
 TzL4JkcVC+ZILiNgJ48ucCnHflNmo4yK1EA==
X-Received: by 2002:a17:90a:dfd0:b0:37c:6130:7a5b with SMTP id
 98e67ed59e1d1-3966d3a8f3amr15824144a91.8.1787750763532; 
 Wed, 26 Aug 2026 06:26:03 -0700 (PDT)
X-Received: by 2002:a17:90a:dfd0:b0:37c:6130:7a5b with SMTP id
 98e67ed59e1d1-3966d3a8f3amr15823968a91.8.1787750762781; 
 Wed, 26 Aug 2026 06:26:02 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668767d65sm4581108a91.8.2026.08.26.06.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:26:02 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Subject: [PATCH v4 0/3] misc: fastrpc: fix ADSP duplicate session creation
Date: Wed, 26 Aug 2026 18:55:48 +0530
Message-Id: <20260826-dup-sessions-v4-0-35555d2bfed4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFzpjmoC/3XMzQqDMAzA8VeRnldpa3F2p73H2CHWdBbmx8wsG
 +K7r3oRZF4C/5D8JkY4eCR2SSY2YPDkuzaGPiXM1tA+kPsqNlNC5SIXhldjzwlpuSOOoMACWGm
 MZvGlH9D5z8rd7rFrT+9u+K56kMv2AAqSS65yk2koS+Mgu3ZE6WuEp+2aJo2DLV5Qm3EWxc5QX
 PAKtHDGmgJUeWBkm1EovTOyaOhSSFOh0yj+GfM8/wAmIqArNwEAAA==
X-Change-ID: 20260609-dup-sessions-ea2acaac1994
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, devicetree@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787750757; l=2213;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=9P/mxSvpF3bR3tFDHNmq61Ve/osDwxIH3CqbWQqC31s=;
 b=4xm/wk6ic1DGhn00WjuMS8HNa86/c05hLVp4f0R7zF9xenCMKZMI3wJW0E3feBNaMh6c/zsHG
 t1mlONpYoqTDhC84KX0WKzxs7vtwsg2xsjynmroapNTdzt/Ie0juo/4
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8ee96c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vdYYOim__DPnj8GFrYsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMSBTYWx0ZWRfX7aRSH2EwqRQw
 snwnLwUAkfIIMsHXh6jIGuh3l/FtnujyoqsTVYb7HMiXqTw5BLpQP9hCGDtdZs6rpqq58BcIPIa
 YAmh2ZltpLR9qQjhMdyw/HR9zmvIQIY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMSBTYWx0ZWRfX5RaAHZRhd8+X
 nuYVksaO28taTzWhSzQRmwamVrHNL/aulDsOAfo7V/mSQJPbEK0HUfLJvMNYQ/SrJiWESBJdtUJ
 /luybaDc8MVHY/rioxkLVioo1yA1granTsZscyXxNZ9mRDpH5CGCRtXNDJ5M3oncYUcyMt3FOz2
 hm/a8GCYVOiPC66PbFjiRXHCnEgrghhGt1ctwuAuqpN05p1M58foHQL7FIM7bNZC/dfhlzyz6CH
 7Nb98W9ZrbiDDjY32gWyWVi9PH8OUJRLYSoqxlhMDqZ2BWajRzVSqHZdM8paLu65nJO64bSxtyd
 OnrfYNxkP7T4l6U3Ld2XFWq4RdrdMOrHsU+GcZFEOOpou6Ayiz2kFCmOHSWhySI8G52UBGAH6jD
 uMSUDy2K2F/tCHoqoXghvfjaIjNutCycalsPJGW2rCI6+6XszdwA3nMpNIaDIbqjELPzyiVuPkk
 w2v1Uyw1yijPHb4GxsQ==
X-Proofpoint-ORIG-GUID: HRLxBUY9lpSblWtVBKJqYXxM1NFjA9Gn
X-Proofpoint-GUID: HRLxBUY9lpSblWtVBKJqYXxM1NFjA9Gn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260111
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

For ADSP, only a limited number of FastRPC context banks (CBs) are
available. Each CB supports a single session, which means only a few
processes can run on ADSP simultaneously. If all sessions are consumed
by fastrpc daemons, no session remains available when a user application
starts, causing the application to fail.

To work around this, some DT set:
  qcom,nsessions = <5>;
which duplicated sessions inline during context bank initialisation.
Upstream feedback indicated that this policy does not belong in DT and
should be handled at the driver level instead.

This series iterates over CB child nodes directly and synchronously,
replacing of_platform_populate(), and moves the ADSP session duplication
to the driver. The qcom,nsessions binding is deprecated in the same
series.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
Changes in v4:
- Rebased on latest linux-next (a8406e6c0b79, 2026-08-25)
- Link to v3: https://lore.kernel.org/r/20260824-dup-sessions-v3-0-4b019def4e0b@oss.qualcomm.com

Changes in v3:
- Add patch to fix async probe race with of_platform_populate().
- Rename fastrpc_cb_probe() to fastrpc_cb_init().
- Reorder series: sync fix, nsessions, binding.
- Collect Reviewed-by tags.
- Link to v2: https://lore.kernel.org/r/20260708-dup-sessions-v2-0-da40f9c98a2b@oss.qualcomm.com

Changes in v2:
- Added patch to deprecate the qcom,nsessions dt-binding.
- Kept the logic unchanged; only split into two patches.
- Link to v1: https://lore.kernel.org/r/20260609-dup-sessions-v1-1-26934abb9fa3@oss.qualcomm.com

---
Vinayak Katoch (3):
      misc: fastrpc: iterate CB nodes manually instead of of_platform_populate
      misc: fastrpc: move ADSP duplicate session creation to the driver
      dt-bindings: misc: qcom,fastrpc: deprecate qcom,nsessions

 .../devicetree/bindings/misc/qcom,fastrpc.yaml     |   2 +
 drivers/misc/fastrpc.c                             | 112 +++++++++------------
 2 files changed, 48 insertions(+), 66 deletions(-)
---
base-commit: a8406e6c0b793ce0788019683837c40855b55995
change-id: 20260609-dup-sessions-ea2acaac1994

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

