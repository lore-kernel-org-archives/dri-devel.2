Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592D606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SmkeYydD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RqB+722N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87C610E5DB;
	Fri, 23 Oct 2026 09:03:31 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A9B910E06A
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:20 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7F9ww2067802
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=plJ8RgROZwLvnc/MhxP/A9BjyrRLx3YDXVe
 OTpt+v/Q=; b=SmkeYydD58pSevZvjyec2CUU2pp7BfKjHtCYz8FL05LGbd2sPrw
 D0Frst/9UHWvtSLjJnvEd6cXnD1HsVxcIwLcyAKIHmht0FkL2ZIQmHJsMOS4r/tn
 2ZTkAMXKbexvU7eEYuEPVxk132ooHYS2+VmwSB7O9wHpvyLlKObMi57+CiiqMk/f
 gMZiR2+DZxqVnVxNmhCRegbYdx3Dyh4IGJFyOdAGqnj+33A5YTv97//HPrIRmmDb
 bY0ewtrehgJiyabNmvdDmXH+y9fL9d6iQl28pb6aLl/+r9GZ66IaVycL3MG6Lx51
 inNgbD+U62LkRt0tAnmX/VO2g0zmjgXO8FQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw3c3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac16335199so634739a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792746197; x=1793350997;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=plJ8RgROZwLvnc/MhxP/A9BjyrRLx3YDXVeOTpt+v/Q=;
 b=RqB+722NvpaCqLZFr4f3Z6f5e5mTPpqD7CFAHchSWNEyiv7c3c2EFOJlktm8kx4MX+
 ntrMv+FwoKDo4z+VGRtZFoaNAXivX7vtAp0bNncpfjEO7quK/55a9azLmv2kjrLzJQPM
 9y8U6gdInYBfBsZAoRn+TKoO7+gPtsdta4g9f3gbMmeBDryRC9W0uHFxEKz66gZJuQsG
 lvx89B5XzruCsDa1s8raaZWH/gkjQeGn5400GzqUvi8kP9wnyKOhX7QNeMwGQwdI9W7v
 TrFdNoIVi+4vXFf+UEtx8F7jaaQYkbTuoo77B+0ad4Q71CaqghuTWJa7nTQPE23F3efp
 rJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792746197; x=1793350997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=plJ8RgROZwLvnc/MhxP/A9BjyrRLx3YDXVeOTpt+v/Q=;
 b=04zq7jZ0mK+yk7MAjIJ/PRfnYchYtJvIEMBmZy/OSX3BbfDp8vpDQo9C23V/K+NeJI
 zAJ6OE6E6YEau0J49c6y6eELsV3t2h8Y/hQJU3SFw9BiWds9USBPRoioCW22ynmETf2Z
 5rCKDb+qEu/yQDjF/2oX1GFY81Uf6oMAFWU4KuLj4zT+SyRBSsOO9NMphy35/Nopa2NF
 Ak7t4NXGI3Qgwx4cYEo+QmXPXnRmroE1zD92Qpi0UG9VxWrx2sQcFw8Hk47f/X1B7xGP
 mtxv3ET4wL81ZH2z3915a//MFpMoKgUgivzZsz/Mn0khv4Sd+9aDoTQVfFtJflA7iG7u
 /H4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbzyTDeD03hIyMTW74qMKoSGPEkLM4AmbKkNxqxT73RbR/PwIozJ6QYyPCrxByYy1Ix937UrY2e3k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIpNVIJ1AuFWKFVdcNwWToje1xXkdKC7F/roo+vp4BO3BllepJa
 O/e6PclD4KDIuCC/mHPhG6MrAtC5lNeyM4P23W8R0VfWjjvCUwxrTYrnoLzpejmuDULon0GdmRC
 uoxEIw/mWxLiMWlwaF2nNTVw+zgR74Zmm/X+Dbu3qthkDSHixjv8zgN5yZNKbZe5AuKkiK04=
X-Gm-Gg: AYBFou1OG3S1d4Slts1V+vz/Q0c5hUiOpLdhGvlDW90wyywEDFthBMa71ArRjc+I30n
 NT08p3+YF+v5Jo3xLF9dAnystvnfOB1Rqi6VhtFF3ttlD3ESSA68Jfx7b+XpmqDnTN8qbcVMOKb
 1hMfZuEwg44CxcgqStdbVEFceE4XN0MzQPkIURnphbCX8T9babE5posDXibogXveqhHPoGnx+Ts
 eMN7uw0flv1yJ7WgOonYpC8SLiUD0FcqIcNJI44FtESbj6dZNoLS3tdurppXDP3HqRq8wNqjUmw
 riGKui15qo0GosZD41p7S0azW5yw3S8aRiDoQ0iGMpjr0bYF4dApCm/eBAlZsD/aUYwUuGO61ur
 9dVvVR3+wDFsH2d80EE2vPgoUUXiCCJresg==
X-Received: by 2002:a17:90b:3dc4:b0:3ac:8897:7b98 with SMTP id
 98e67ed59e1d1-3adce0495f1mr1385872a91.32.1792746197388; 
 Fri, 23 Oct 2026 02:03:17 -0700 (PDT)
X-Received: by 2002:a17:90b:3dc4:b0:3ac:8897:7b98 with SMTP id
 98e67ed59e1d1-3adce0495f1mr1385839a91.32.1792746196810; 
 Fri, 23 Oct 2026 02:03:16 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ba69ca4dsm586273a12.0.2026.10.23.02.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 02:03:16 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: [PATCH v2 0/6] arm64: dts: qcom: Remove FastRPC compute CB9 entries 
Date: Fri, 23 Oct 2026 14:33:02 +0530
Message-Id: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jOAO4J-w9Hk7ufsXDbbpRcmt9tpSTO4R
X-Proofpoint-ORIG-GUID: jOAO4J-w9Hk7ufsXDbbpRcmt9tpSTO4R
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb22d6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=FW0NidNlYbm5mj9sKN0A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX4dl68f1suCwi
 9qbDcjoYAXE0AwBkdLeQcstkBXvu7N6iUMZSDXNijQnx8ZizKEXUEjTY0ZmzCASgs5v21CdMNkg
 avMt+dyFQdHk0+qzsOEAkYv+UWj0LFM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX1kYIF6R7+YBW
 ivOwfSRmFwvwtId2gGGCXUYW6OB8bPK/xaqb+DI6EBIWhbmc6xdOuVvLJFKsFsn8j5TZ5MD7CXJ
 KVxJNQLAsc6Fbl1A5654pBAUt6ZO45eFhMZv1xVNoh2CSc33auLvCnAViuSTazQ3BjLNUgkwFUi
 GQb380q8kVc36fCaVQ6VpIqdwfntS03ObDuSjTxUjOVwJSxO2HUbEGapXG0Ivl3o2Jie55TZMZn
 f4I6+yU8/PMH1SuKwxL0OXfnHQIlAVQpvSf58Wl+pnCneL88tFcsE2U5DQSZITftDbLljOEhxcC
 hb9SEUrLFbgRGPTcP6AbadTgRoX3lFY15q3h8iilQXHuCwbfc2PI8Tr69MJtOH3DIXt/RpCLWot
 rTDNciC3/FU9XhwCuJvQBNGwt2n30GTTy74TQdV253JKWlopkX4YuoVwUTQH4w451jNiSVg7Why
 Dn+9N55tzdDID60Udpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230035
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Context bank 9 (CB9) is reserved for secure use cases and must not be
exposed as a FastRPC compute context bank for non-secure offloading.

Several Qualcomm platform device trees currently define compute-cb@9
nodes, which allows non-secure clients to select a context bank that is
intended for secure use. Remove these CB9 entries from all affected
platforms to prevent unintended usage and align the device trees with
the intended security model.

This series removes the compute-cb@9 nodes from all affected Qualcomm
platform DTSI files.

Patch [v1]: https://lore.kernel.org/all/20261016052042.3755352-1-abhinav.parihar@oss.qualcomm.com/ 

Changes in v2:
- Split the changes from a single patch into a per-platform patch series.
- No functional changes.

Abhinav Parihar (6):
  arm64: dts: qcom: lemans: Remove FastRPC compute CB9 entry
  arm64: dts: qcom: monaco: Remove FastRPC compute CB9 entry
  arm64: dts: qcom: sc8280xp: Remove FastRPC compute CB9 entry
  arm64: dts: qcom: sdm660: Remove FastRPC compute CB9 entry
  arm64: dts: qcom: sdm630: Remove FastRPC compute CB9 entry
  arm64: dts: qcom: msm8996: Remove FastRPC compute CB9 entry

 arch/arm64/boot/dts/qcom/lemans.dtsi   | 16 ----------------
 arch/arm64/boot/dts/qcom/monaco.dtsi   |  7 -------
 arch/arm64/boot/dts/qcom/msm8996.dtsi  |  6 ------
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi |  6 ------
 arch/arm64/boot/dts/qcom/sdm630.dtsi   |  5 -----
 arch/arm64/boot/dts/qcom/sdm660.dtsi   |  6 ------
 6 files changed, 46 deletions(-)

-- 
2.34.1

