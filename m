Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2DA606A686
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fg/3yELy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QJX0rRuU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2126112951;
	Fri, 27 Nov 2026 09:58:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74331112945
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:56:44 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AR7Gb1m3983833
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=rOAEHEPzGPKwtDLIIlA2UT
 DlVpnV1QKTrGiX5W8rsYg=; b=fg/3yELyYacEvRINvuplTYIxEwVX4j4EF4UenE
 f4FY39jzeqWtshjVia0i9uoGDEchuG8u799JuQ+/7wW+FqNGB9mw4eZlXs1uKAVj
 5CdjaYUGufgGc2GEjplaE94HSYTHyWrNYw3H92YmVdZJeFMuQdGiC5ywWD0kQm3i
 zB9ax5guZqTQJ3SpOX2Ci3nUPIcEssDkwztA+Ph7jA//yhOryvqkrx/oWdmIb0AM
 YolPw9Dv8FAf/f8HEgm82GRPDOPQSgJD72rH8gcyjKUa7jpzOW1k63PJUZ6cgQKG
 1PWK4ShRJQyDkNRN/hKYQHVb8Qbko1Mvt+SMCp1WyH1M7C8g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u49adxs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:56:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ed08904845so103769295ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795773403; x=1796378203;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rOAEHEPzGPKwtDLIIlA2UTDlVpnV1QKTrGiX5W8rsYg=;
 b=QJX0rRuUr5CgxbMsdvhDKkmkY2Grn5IpcRz2jg/qvZKXbLkVMNtRGYx9nc/A4BVo00
 ulVRErxyNMZWxhcUB5tjQnbOIgLv911fGwYDjvzxgVyIZsmuoMaHLTdgmwPSh5SgnvMR
 LlQku1hF6zSArG0vtPkEJ1x0xh5r9uhCP827yJhzGhk+N4RQvr8dtrWnTYXWBXa+/lc1
 kOoGFt21M0AbLYa6IFdKvr6p84S9YpngYsHMa8QYQOeVDtBk7FQ7Q4IaliEoRUFTXEvs
 RbTAtAAjg8uwi+GVd55/NC8gYf15sSheuBoE8ttA9kOHA9kBvpiOwcqxfsfi9Qq6HBlM
 iUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795773403; x=1796378203;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rOAEHEPzGPKwtDLIIlA2UTDlVpnV1QKTrGiX5W8rsYg=;
 b=kN3xArWh6BwI9aDyWrADY58RNT/ufLmGcvudtmLxzLkh28ld4vuKt1vopvPpoON+wL
 BWpMl8LV7eHCvyGjOjG0OzObtd2cmpBFu/+pk3HwaHw9HROWGEMl1AMrgS5ERVwtr7w+
 77pz9V28sdMWPyxvS4eREtS4RORALs3uG4+7vRvkozj1fcDJKGQwzDAUK5nnzFIoUGB7
 zPQGd324NEkYPKZAhTdk3yewB9am8uKDb2R3B1G6sEZJaWaJlrpQC71IgtSQ8XkXhUWN
 oVaV8CgTVmF58nnxeIorkL+NwcE9ZhZXLK7cAjbo7ujZCnW2O2ooCATdCypT/GvJ2wrO
 Mq2A==
X-Forwarded-Encrypted: i=1;
 AL+hErEjtZhVz8bcU94reqztGh0jkiehyUMSKz/B3kz/x/WcNmsRFJG+iDtlO+64WG9BQ4V3UJFe6wK4CKQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+i22/nNnVtSA254GgfyeZxV9N7FNr43nTfewHmOUfWKzybF+nH
 GRODyFrL8q7djmc/JhpAs0nFpU/qs+xjoyKHugSo67RKjSdZ5s59GB0blkmDgVjceZ7VwegaqVb
 8j6ZSPOyZzQWTxKrua4Sda/uE40rs2ZLhbTw6YxXRvMKG4I0fgrPiSGhsMLY2XpmDYlc7xZk=
X-Gm-Gg: AZFdTZd9DR33PYCHAbMXHTqO4uW2KMxExxwlD1wmYmdJg2nWVaTPLHb6xvPwkXiDRUL
 Nj4M49HYx8ZWiJoYc9RmLDb2B11B8XnojBQ09F+FP5nEMklSabFihW/NHiFOS7D4mxD+BU2MPZ+
 Is/pHRJN8Zq3YFXjvEBnS8Of0YN3723jkS7WTSnSCBsenPWgs951U/p3pgNaqnKACl8iX3760uV
 Vdt4wQV6Ch1miTu+pKQCiBLJ+GpW7boOLCx58FGPhnvwhAJ3/v6HgUaHUsuUNqu18UinvP7NI1m
 S4382zVhiXUxAzcxX6RwC1l4SiIvLJ9rOj3KlVxbB/2RpF44TdJk6IlQuvw+B2RhkdByJabX420
 2Q3FpjyA6KqRM9bIbd/jykfqIpVdoV3BgA7ci0Ah1aubhIi1Mp3ZoYnEOpro=
X-Received: by 2002:a17:902:e809:b0:2f0:5e4a:deeb with SMTP id
 d9443c01a7336-2f05e4ae14emr222003285ad.47.1795773403054; 
 Fri, 27 Nov 2026 01:56:43 -0800 (PST)
X-Received: by 2002:a17:902:e809:b0:2f0:5e4a:deeb with SMTP id
 d9443c01a7336-2f05e4ae14emr222002995ad.47.1795773402558; 
 Fri, 27 Nov 2026 01:56:42 -0800 (PST)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f14a432sm118132255ad.75.2026.11.27.01.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 01:56:42 -0800 (PST)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Subject: [PATCH 0/2] misc: fastrpc: probe-time DSP capability query and
 unsigned ADSP node
Date: Fri, 27 Nov 2026 15:26:37 +0530
Message-Id: <20261127-master-v1-0-f998ec22497b@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANVTCWsC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNz3dzE4pLUIl3jNBMTUxNjCwszwzQloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0ASWDIV2oAAAA=
X-Change-ID: 20261127-master-3f445438861f
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 quic_bkumar@quicinc.com, quic_chennak@quicinc.com,
 dmitry.baryshkov@oss.qualcomm.com,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: jtGgMv2ZEI--269e1tistZMPCpAuSV8h
X-Proofpoint-ORIG-GUID: jtGgMv2ZEI--269e1tistZMPCpAuSV8h
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfX/nD78Iqq4VNh
 d0t4aM7+2o/FinJZP/IA7vrGuPDQEh3UTnte2hl3/8mI3zeOiJAVaVO0QflcYO+h78/wX7paS4E
 v2yanzCcMjnRsiNN8rPikT10BH378BE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfXyiDYGg5Rrzeg
 v2VizEEkHG0dp77JfCwIT8CU1kHbz0BwDzsEeJDCrJzeWHjaIE4CfXctrhHPs6qi7OjtQTSHjRa
 YqIz3tegpwq3eckVEZKI8GBmdNcKtn+8i6WM9Bnnl3JiwzneKY2cptD6+FZ6AXYp0wiKuG1u8Z3
 X77I/VHQc3LSfNxHWFwrP14wSRflbBxjF72B4jD1moB+dSRPvYPPNLJMn8En8INrvSN3nTPk7HW
 NlagJvUDSymFenoABYynadQEPjbdbo1qO6UKRHIy1obxAtOf82BTw2NMlz1EpfkmK/HKi4ebRlV
 JIN6FX2LLg7RvKKYJ5MhMR51DldZxZLhzARCba7h138wvoIKEDWcthZ0HBkShSivV6Pm3z3KxDl
 y6rmZtiyZo8y0SdI981Cun2/30yuhLEiLt6NvnXv30+9Ft7m74jDxSmVYQh8skqsR6GmLc2ns4m
 8x8TN0Bf+h9yuM/nwGg==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b0953db cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=CXdNUMfnqeXUppiKwXAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270039
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series moves FastRPC device node registration out of
fastrpc_rpmsg_probe() and into an asynchronous per-channel workqueue
that first queries the DSP for its capabilities, then registers the
device nodes based on what it finds. Probe no longer blocks on the
DSP responding.

With the DSP capabilities known before nodes are registered, the
series also starts creating an additional unsigned PD device node
for an ADSP domain whose firmware image reports itself as
compute-capable, matching the existing CDSP/GDSP behaviour, instead
of only ever exposing the signed node for ADSP.

Patch 1 does the probe-time refactor (capability query, async device
registration, and the locking changes in fastrpc_device_open()/
fastrpc_rpmsg_remove() needed to keep that safe against SSR/remove()
races). Patch 2 adds the unsigned node for compute-capable ADSP on
top of it.

Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
Anandu Krishnan E (2):
      misc: fastrpc: query the dsp capabilities during probe time
      misc: fastrpc: expose unsigned PD node for compute-capable ADSP

 drivers/misc/fastrpc.c | 338 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 285 insertions(+), 53 deletions(-)
---
base-commit: a9c48428cbd8d96b26f92631d0db6f8519c5fcc5
change-id: 20261127-master-3f445438861f

Best regards,
--  
Anandu Krishnan E <anandu.e@oss.qualcomm.com>

