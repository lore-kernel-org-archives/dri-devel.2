Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83214CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D47DE10E430;
	Wed,  7 Oct 2026 10:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JJk63ZCW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dIa6uho6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8321210E430
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 10:28:38 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jjQE2970140
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 10:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qJd8c3YcS/jWGwlUkQ1NCk
 BRZMwGD6CmRMTRMWeTdPw=; b=JJk63ZCWnX6obCkxRwKCbG9eLXvvy69Q/K32r6
 FXCp76zClHzNC/W1YmrhyYuQK4IEmoDya1Ce4/hstcLYQ/dIpoIHHhhNvsOxoVty
 hRHUMwSGby/WZRC2w+8lpB8CEK4hk0ginvddCbgXKmQV3DbVvGKGtp2eFW0CqL6P
 kUoLMCWZnFIhmyMwvCJ/u9zMXWoKh3wiI/uvJwZePJlkrUyswGw7/VGUNBs0cNIV
 /orQOd4MF7l1ptg5f+un4Gm4YiQY/wXYa3JqzGgPqVHmIUvc3wMx9G+tLSjh/TnP
 486ioGkRmK0zfkiqHZYi2CRRzFbUKzAvtFbhe5eR0OVm6OVw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c679mv0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 10:28:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so5187075a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791368916; x=1791973716;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qJd8c3YcS/jWGwlUkQ1NCkBRZMwGD6CmRMTRMWeTdPw=;
 b=dIa6uho6PQkc7yW8rcnMoEXYNd/MFBeWRRLeLbcMBIHNnLH9MtLJMElvaGF7cF6EBa
 5zrN0oO8ClORByMyj0vH+5HNlpGTu7kZjGRRNHdT2iuOB3hB20BACtQlgfk/42aZkN7i
 5t240N3pgS8GUibl97dvG0I3aAyYVLPcKbvgqGd2rlleyZlt/pePRbL1upX13/Cs1HGI
 yITdOj7ZUuefrCDnzwacnWQqJuZf/1RJpYKvCqbc2RuGcrfX5P0QdAngP/OYHQzmIWhD
 bIta6x8e5LKyYzrdn1VMRXWSGr/fzf3rjHBOC8f/UO8tsHf5W01GatTeuAyGVE2r/jxf
 xRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791368916; x=1791973716;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qJd8c3YcS/jWGwlUkQ1NCkBRZMwGD6CmRMTRMWeTdPw=;
 b=kEL3K5sMx0A9QYmg51UVm5k+ihZm2g2EonF8F+DWWse8Bg1JwaKhWCvC9foNae6yqz
 cFVPwjOyfIufbxmUOfNXUsUecsSvpoML48bCMAjVC6R1aAjYDZ68cSG4zxw5lHnuTOoT
 Ys69Ts2EYXJasVLz0aeuYLgBNr1JUbGiga2A1E4zPRISrE7aqQrO9COo1wGgjItEBgfT
 iFSp4h2IIieAY92/vem76H3x3ATBpgMBjmJ5R5HlXHwquDiEw0XbEuv1EnUfNQX/CLWl
 qItsr9G7TLg53uouzDCvf7LtjY7B1fBFnUQ5P4yKHY7Uf5BuH68BeC3UzaY96JgRbBZi
 5HMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzy7MPDGBfJPtEvlUZOubx0FD7g0cEM5AvHSBC9KRj6dx7RlbNUW5W/PkjR6TmVdnipQq3FF/xBfKo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLHN+2NG6tpuW54yK30/LEWOUQKfLvDxVrPRNeWR+lGATVu8SBS
 Tkx8GnM8ULOSJllI68S1txkJfoqcHhbffQ12GllKXOz0ss15C9WkdTcn9iYzDKWw39X2GyQ2bho
 Bg063qBl2/0ys+FWmPT/S6bRZE1Rlnf+NB8PeR2XANBhTuUT6G5T/2B4necx7jLktL1Iui3M=
X-Gm-Gg: AYBFou3i55RrkA1f7LrQ6ieNGkcS25z8V40B81JfvmDyPDwrxOwr/NJwS+qT3X+mf2T
 zx8a3/yEqwqw5E+BPJUMztqXU7oVmp8doNorh8I4plvZIHLCmXXJ6aYjBPAK90tOyFW34hVWF/j
 mrHQsBFa7GG5009o7l+lPh95cXOSZgB2RE4znIhQAcp1V5azZNGG+JtTMyqlZmy2PS5rWfUpMRC
 iAU5eqkhCSH+jJLrim7mkQUBLebllMhiwppedAdocGWKcgia2cvxp7y74M+fyK478mkvCLq//JG
 Dc4QtZXExCzNRb6MnBhL5hZBDkKDP4+cELMX9ZQSYBrPYZLEibhV4oElVtoIlgLovvconYhxM9n
 gtaOAUFOBL9Jo1FoLD6KtDG6GN94Jhu6i
X-Received: by 2002:a17:90a:51a1:b0:3a8:c0cd:57f7 with SMTP id
 98e67ed59e1d1-3a8c0dcd0c2mr285663a91.23.1791368916209; 
 Wed, 07 Oct 2026 03:28:36 -0700 (PDT)
X-Received: by 2002:a17:90a:51a1:b0:3a8:c0cd:57f7 with SMTP id
 98e67ed59e1d1-3a8c0dcd0c2mr285649a91.23.1791368915689; 
 Wed, 07 Oct 2026 03:28:35 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd0a8cf2b69sm1221334a12.8.2026.10.07.03.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 03:28:35 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Subject: [PATCH v4 0/2] arm64: dts: qcom: glymur: Fix fastrpc compute-cb
 reg values for cdsp
Date: Wed, 07 Oct 2026 15:51:16 +0530
Message-Id: <20261007-glymur-dtfix-v4-0-31f7143e759b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABwdxmoC/3XMQQrCMBAF0KuUrI1MJmm0rryHuEjSsQ3YVpMal
 NK7m7oQEWVg4H/4b2KRgqfIdsXEAiUf/dDnoFYFc63pG+K+zpkhoIYKkTfnR3cLvB5P/s61FKp
 EbZUFZHlyCZTrF3c45tz6OA7h8dKTWNo/UBI8X1nVRlsgqqv9EOP6ejNnN3TdOj+2eAk/DfllY
 DaMsqLCLYHb4B9Dvg0BoL8MyYErRWhdKTfgfhnzPD8Bz2IQ8zcBAAA=
X-Change-ID: 20260922-glymur-dtfix-6314526b4b02
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Mahima Bhattaram <mbhattar@qti.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791368909; l=1874;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=ykhcPrrbeFy+nNEr/jpSJsH0A4nJvqK4aa8osTz/xXY=;
 b=R8AdO6T5D4uOuzoM4i5eqCgiEViZPN8V/RpmXDihtqOw+o1i/IEgeieJKdcFHlkCHs6su6iKv
 qwPyaLRSPK6Ap1LGJg0SWMApZ4CDqtVVcM8KWGLz39r//I5d6OlNGd0
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfX5wJV2sb73Co/
 skA7ITt8D+RX2k3BYFRkECkaa8yEposfCvA35qBmYyu11T/PP5YVCjBhhloyBNoI1PaXFCFgJ/m
 A0y6Uee3Vc4sF6+jabEIo2fz0MF96m4=
X-Proofpoint-ORIG-GUID: wYiQnQ4Y96_nFiGu0x79ReWeys5_kO_B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfXznVF2I6LU35W
 qSi1tnuzjQ7TW5vse/D1QE35DuDef66esMTW4YEg6FYoT7mmjYcmTKwNCVhRyqqjIDoSroghkQb
 CWKYo32VxuBzHEUfIZ+DOw2jlYhqHh9qS8HEI/Ip/ssKOczgSlDkOitREmo1rNFmVXQ/CtPdfbZ
 FK1TO5WSsBe6teQ/30msnmb/8920LaVOMKSj+PCsV/auAYcsMRtwEMOivrI8MBgXsFvoJ6Ze4Fk
 z4YyGhVhH8EtPegD3Wgw81DX7+2n0BxHCblhm5iSjJJien2ZqPCHGUMe5zWQsjhxXX9sYGHbybQ
 nDzkkHHiCnqKhg3YT3KDsarB98+J5wgvxz0Y2viXB5J4SwG3iwlQQ9ySs9pM/q6yOwW9fKOqONV
 bXU0StJgYmF1mL7dXw0w5Ac2Y0nQcRszStJc5vf8JE6XrL5GDliWrvNA7oQU4MliXn8pvwjH1N7
 jtvSkhbAgs9BqdztA3Q==
X-Authority-Analysis: v=2.4 cv=OfcNnRTY c=1 sm=1 tr=0 ts=6ac61ed5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p04a6VuR7GaqaFzguDYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: wYiQnQ4Y96_nFiGu0x79ReWeys5_kO_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070041
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

The reg value of a compute-cb node must match the SID (the lower nibble
of its IOMMU stream ID) it is associated with. In the cdsp fastrpc node
of the Glymur SoC, three compute-cb nodes had incorrect reg values that
did not match their SIDs, leading to SMMU translation errors.

The fix renames the nodes to use correct lowercase hex unit addresses
(per DTS convention) and corrects the reg values. Since the fastrpc
binding's patternProperties only allowed decimal digits in node names,
a binding update is included first to allow hex digits.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
Changes in v4:
- Change [0-9a-f]* to [0-9a-f]+ in the binding pattern to require at
  least one digit in the compute-cb unit address.
- Link to v3: https://lore.kernel.org/r/20261006-glymur-dtfix-v3-0-44e2bc5370c2@oss.qualcomm.com

Changes in v3:
- Add binding update to allow hex digits in compute-cb node names
  (required since unit addresses must be lowercase hex per DTS
  convention, and the corrected reg values >= 10 require hex names)
- Link to v2: https://lore.kernel.org/r/20260923-glymur-dtfix-v2-1-a4b1928e0c72@oss.qualcomm.com

Changes in v2:
- Change unit adress to hex.
- Link to v1: https://lore.kernel.org/r/20260922-glymur-dtfix-v1-1-159da6b0eed9@oss.qualcomm.com

---
Ekansh Gupta (2):
      dt-bindings: misc: qcom,fastrpc: Allow hex digits in compute-cb node names
      arm64: dts: qcom: glymur: Fix fastrpc compute-cb reg values for cdsp

 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml |  2 +-
 arch/arm64/boot/dts/qcom/glymur.dtsi                     | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
change-id: 20260922-glymur-dtfix-6314526b4b02

Best regards,
-- 
Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

