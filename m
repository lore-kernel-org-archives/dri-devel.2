Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8994606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Gwnvt6+C;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f1slvHKn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 174B810E1D3;
	Wed, 25 Nov 2026 00:07:02 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1886810E1D3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:06:51 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AONwE3h2728234
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=wYKFLzdeHPvc7kprMqVT1E
 cCOKLlxOc4BYqtnLQWWuA=; b=Gwnvt6+CnIy4dUzedFrjCud0kA8qrm8m8Hfzg3
 1Mv8sebwr5DbXUWJzU8nabecWX/0KC4hhZKvEWT6Z2d0TZ15cIzF//16vWs4+9um
 H6WmlWE+Pz9syr9jWBMbzr9Mu5z3SSnTUKIRKh6cYQectGS6uLcYloZN2BH9YXkv
 f8qAQd15eKGvKHZbXWQQ9cUqDeRvJqX0sHi3wor5gVjI4yrcrR3As9Jo7lbfAjfb
 JutfCyqN4KVrRRs/cEoVq/23L3hTEWEVealVTr0+FNmCkQGgW4hqMglRN3QuBljG
 SkiZfblVOT+KxpPZCPNZWuGRmDsWvjFcexxhbC4I7bNBu26Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mqbg106-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:06:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-386c3309469so1288200eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795565210; x=1796170010;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wYKFLzdeHPvc7kprMqVT1EcCOKLlxOc4BYqtnLQWWuA=;
 b=f1slvHKnSY9E2T2QmBsJwqXq7/iHrWmJ1Hi8/rZEEbxHhIJATGgWtl+lHT47g4lamL
 9pRxK94Frgk5Vub8G7E+1RzqL6YJcBpCcTfKnzccldynsVAYFRZ8SLNAxbRGG++TLHWX
 62nvgqyKehPMaIevAOE980OPv6fIVq1nH2S9+wU5EEWYl9LvXcFzFUVI/JSvWQuM0rY/
 Tv6Q62PYSsn5jTYT4Vvr5drL5y9lghwP+w+GD05YxwDZwVuS4vGD7h5HfblOYuiRecxs
 SCW11kWES72MICXct4rthVkHmXUW7xqKDYsJ35qfdWW9fOWMqRWunwJ2UJxnhpJp0lgy
 Kylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795565210; x=1796170010;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wYKFLzdeHPvc7kprMqVT1EcCOKLlxOc4BYqtnLQWWuA=;
 b=Bbr+5/hbwlk51ikvvrNp9ruNUBE8TLOqDv6vzrXiNjI1GzgtkbA2A+A92twxpUUsfy
 4ND6b1UbRa74YMWrG0FfQIG9FN/N8nTGI/XH63YffuXd6nmL4CbC0oKs7waHT/gpOiSI
 bbDqEnVovZZiNEkPdLHJQ1lfcec/7Ezh48gjL5FaOPQAk501x0Paoo6CGQ5qew9iJHwb
 1ldPtoIfNowizKuZQ/NCd1TGSt+7wZjFvogWm6Nn06Cj9FREfgZ8Pjc7lMiHf/rDydbw
 6ycFcpZeo5/WubUO+vfGgShnAx+BYX45Z+fi46T+q7y248fMLStYurC9UM66XgCif2TK
 uDZg==
X-Forwarded-Encrypted: i=1;
 AL+hErFH5jXknimaWUnU6x63iasPUMOxAO3XEidut21r/M3/P61KN3OmURZM6I5gKTl7h6jdimsaH3OMvY4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/pCPUEOHk+P+CSUahk8N+kMEjbDPJJotP5gMRDP9Mw1F+z5FPp
 bVNLtNxRs0LknWw65uBWQptDH0QlmZspTFIL+5970f0MraBW+EVHUpGrkjK2rcdqRUArytniTOV
 SW7lXZMKWAjwLx2tqVOxzSsk+imEiNIUWnEY8XIA9x1YTMxOJn5vT/+xuXurX8sy49ylnXg4=
X-Gm-Gg: AZFdTZfZ20KqK0P+dYNkqz2tA8tlOcfB0guUFjDv57bDC7XhBt2ASsxUqqCxxQTx+d5
 RlQzr8DM64hy0w71Bpl+k0W4p1lOSwGg4aYKuyTik3Oq9+ZSCxnzj9RDSIEvETJFr7/KKT4GLDc
 YIv37OfQK9iTbhSp9253+UNYd8vc1GLIkPCJjR4oJZxTMi5Aig9OkwJX5iEx0qiRooW58x/+UFs
 iE4lzgkxWxN8T5PotVF4XAbyYGMtMc2ioYDp/DMRNiVcLt+opDSE6LxS6+svxrVwczs2K2PiQMa
 tqXz6xGjbGf28riDmfq+ran1mRALT+9+A9Z5CEyYq8wRJ63aqxkHHXmCW/iuwsqLmOIHelwwhVL
 d5LxI8lwE2dzr7Uj5av1V2ERLZJ0FoUkYzhbaa+mLHPPhJpFMLLJTFx8Yfw==
X-Received: by 2002:a05:7300:f496:b0:385:551d:854a with SMTP id
 5a478bee46e88-38570845477mr15682266eec.28.1795565209614; 
 Tue, 24 Nov 2026 16:06:49 -0800 (PST)
X-Received: by 2002:a05:7300:f496:b0:385:551d:854a with SMTP id
 5a478bee46e88-38570845477mr15682238eec.28.1795565209009; 
 Tue, 24 Nov 2026 16:06:49 -0800 (PST)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c371esm47494708eec.23.2026.11.24.16.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 16:06:48 -0800 (PST)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Subject: [PATCH 0/4] misc: fastrpc: add HPASS domain support
Date: Wed, 25 Nov 2026 05:36:40 +0530
Message-Id: <20261125-fastrpc-hpass-support-v1-0-cb1d46b29e3b@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJAmBmsC/yXMTQqDQAxA4atI1gacAa30KsXF/MQaFxqSsRTEu
 3faLr/FeycYKZPBvTlB6cXG+1bh2gbSErYnIedq8J0fnPM9zsGKSsJFghnaIbJrwZjjONAYXZ9
 vUFtRmvn9+z6mv+2IK6XyncF1fQBulXT0eQAAAA==
X-Change-ID: 20261125-fastrpc-hpass-support-bdb86e8b15d7
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, quic_bkumar@quicinc.com,
 quic_chennak@quicinc.com, dmitry.baryshkov@oss.qualcomm.com,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAwMCBTYWx0ZWRfX8C3eCMvCz10j
 N4a6M1jywK+LqKdJq+snewMmvR2IivPdjey5H4YWuBuYGAhnCVaFXv3uBqZfBDvqJEvdMPlV6Nk
 yFSWguESwWrb9fkCbiXGVFlHtiqzf2s=
X-Authority-Analysis: v=2.4 cv=Bb9NQbt2 c=1 sm=1 tr=0 ts=6b06269a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=yezPJc07dsF5jmqqbk4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAwMCBTYWx0ZWRfXyJWnVXBO6TA+
 8Y10xo7lU+eNMZBXo+lAQqCFNWPQJNCF9AljPgGmArFqhHfU5K+O6HTSoPQkgXafGILYzrY6BQl
 VohmSHd1+Q5xz1z6b383Js1WRCViYVGtdOGhYsXzrddOh5l8UIztEV2thzo/vRP5xCieAYKelOG
 emGt1TA1hiy9weeeOmdhzgt6gREWz/PMJJ3PXANyJcRImvj4CEVvIbf14iJQs7TwzCaNVmn93n5
 zLA4UIlK0iPu2r+GJVVwOcsA85xxGgKJbL9aiEGS9XQhZq05UDECQh1j43gp+GxnrvAIiSN36Ye
 JXu7oM+CH1MmdJAqeUca2JmOx4rCwkqzPsTrFmNxt8YvSlEQc4m+vmfGMIvejiikma/lS3cBDEn
 yBoc96B0o1No3B/tj3SV19rdN6mtM2AtD7k/1FCRxBW1bJjcIDQQsGV2/ishDbcrPloW9ex6to6
 KmOCBbE0Yh6j7QRCyIA==
X-Proofpoint-ORIG-GUID: 9TgSCn7S61IO3mLc_rhkvkst4Xf5OLBb
X-Proofpoint-GUID: 9TgSCn7S61IO3mLc_rhkvkst4Xf5OLBb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250000
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

HPASS (High Performance Audio Subsystem) is a distinct audio
hardware block from the LPASS-class ADSP used on earlier targets,
with its own shared resources, audio interface block, and additional
integrated processing hardware such as HVX (Hexagon Vector
eXtensions). It is described in the devicetree with its own "hpass"
label, following the existing fastrpc convention of distinguishing
DSP domains by label (adsp/cdsp/sdsp/gdsp0/gdsp1/...).

Depending on the firmware image it loads, an HPASS domain can run
either an audio image or a compute image. An audio image only needs
the existing secure fastrpc node, while a compute image additionally
offloads user compute workloads and needs a non-secure node for
unsigned PD support.

Which image is loaded is only knowable by querying the DSP's
capability attributes. This series moves that query from userspace's
first FASTRPC_IOCTL_GET_DSP_INFO call to probe time, so the device
nodes registered at probe already reflect the DSP's actual
capabilities instead of being created from the domain id alone. The
query runs on a per-channel workqueue so a slow or silent DSP domain
does not block probe() or delay other channels probing concurrently.

Patch 1 adds the "hpass" devicetree label. Patch 2 adds the
corresponding HPASS_DOMAIN_ID to the driver. Patch 3 moves the
capability query to probe time. Patch 4 uses the queried capability to
register the unsigned PD node for a compute-capable HPASS domain.

Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
Anandu Krishnan E (4):
      dt-bindings: misc: qcom,fastrpc: add hpass label
      misc: fastrpc: add HPASS domain
      misc: fastrpc: query the dsp capabilities during probe time
      misc: fastrpc: expose unsigned PD node for compute-capable HPASS

 .../devicetree/bindings/misc/qcom,fastrpc.yaml     |   1 +
 drivers/misc/fastrpc.c                             | 259 ++++++++++++++++-----
 2 files changed, 207 insertions(+), 53 deletions(-)
---
base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
change-id: 20261125-fastrpc-hpass-support-bdb86e8b15d7

Best regards,
--  
Anandu Krishnan E <anandu.e@oss.qualcomm.com>

