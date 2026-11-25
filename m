Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE0B606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 00:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fmBTTkKp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dn+Htvie
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF0D010E567;
	Wed, 25 Nov 2026 00:07:16 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA2C10E365
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:07:00 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMb8jE886823
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UyJMvArk42W6bIBhWSb3g/nU4qxfS0ShEh08XxU+948=; b=fmBTTkKpN9qjMHjP
 aI5W3+MqVvpEPqvq2lQTgJzVSIcEPyd89ESxteRsZsmzrysbPJvzVTo2mlAbWb43
 Fzf1GJseclGIgqXPzHqAi8FeSg2gzPKsXI0f5yRb1n6Md6IWFYl4U/D8MW6psH3k
 peXAIJeMENIl/LYx6fDw1qj10VjOb/QeIcpI5C55L39j1Pcf+0uB7uo/mqOUV40H
 kkT4aB5vPLx3rzFmjCiNQOzouM4/EMdbURpScMm0Ovzevau4JoTvkLSILA8CnEPR
 Bhx8I0lJ0KL+QGDhmthyvqlMQNIv4I5J4KwVBlpM+CE8zjZNr4J+efz2O3ppmLs5
 hvsc2Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rhcexw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:07:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-386c3309469so1288275eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795565219; x=1796170019;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UyJMvArk42W6bIBhWSb3g/nU4qxfS0ShEh08XxU+948=;
 b=dn+HtvieklEupt8srfNe+uxQ9njEqKh5RPzjAjnAnSmh7CSJpWw1YZWmnHyx+wCTc5
 MCJusDrldhP/HZQwm1UAwfivTNuRNkHn2vkE8In4S8vXPTeTJum6q90dAZzl+8blHMgK
 o7ROpJq3T/nSPBtUSJ3rSUmYa8/tf/aG3aCwPWy5lO7pYZozrv5VAUc7yaN49W54z+BP
 FOG9jgNUugijZZ+uy5RguCw9B4t0KRUvUsOj0dr1ps8sXR3KHsKA5IYU3bLVULAVmpx1
 8yF9xwYHwY0Ck4SRmsebJOAdCTGx48dFilBegBiZoEj/NbWDxhlx04NesURSpiAjRVkS
 NIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795565219; x=1796170019;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UyJMvArk42W6bIBhWSb3g/nU4qxfS0ShEh08XxU+948=;
 b=jphUYOax2Pfyl1yZE2T7p1b3Skr7J+mikU+oW9DFCdxXtR1Tlbagmgx5c8H8hVmliZ
 OLGzyjSAsKdCnMdKbXEKiNteFq+YgV8Z+X9p7pwW8NEPCBrA0JDXuhTR2gZlEsnFJw+C
 Xq8z6g+IW5cdN1AoiHRxEMBXAP/uxnwdWlrO8hPjZIrqKoJwIhXlWSBMtdW+mFbMdOQn
 JDpUyJZMNVKrSfOOfaTaI48ysc4Z02B474vhFGq8eFqHPpQ+tnSOnGrC6Qe37RYi2Kh2
 UDpdhD8VivFngkPCv72iKgNVpfQ2QoWYUGR7ZuuDtS+Rqv6TMtWywb5kVmW+a8pPXFAu
 C0Lg==
X-Forwarded-Encrypted: i=1;
 AL+hErGh5hFEbSreIdcW2xnxVkGOdRYUk8FibsTdtjaKDwrNxbhffVMFhKm3O5mRNp8IqLPkc0mqhBazKpc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+wxhOcXrbcAoQ6Cy4niGCN6hf77bwYWuWHqOTnCMFxGQMVY8NQ
 h99JPvDqXc1XqunWaroNKY+Bzl8vf9JXWHCpNr4GOX4J3knFy0wDxD7ZGOHHtXhnTLA+gfmb2p3
 JaGRehRKc8m8bgEFHLZavQitlS3M5oOICS8AQwWoVp35bgRQFFuCceftq9gZSdeLNFGKLj7w=
X-Gm-Gg: AZFdTZeEgDu1i0MG5HJTtuqU648v7VXnQGjPiz5RwgaWT7BBh5IFZJmOxH+pJhzV/rP
 I49K3Lcv8UZyd/wQ5N87OB3l/NA1hn47eItInf3m19scjwora0NTTYpk46yNwK7s+wK3JIqFOTP
 plCxKirgKB92XulT1yBAQkDoJSPdJj6eVo19RD26xjMJplxiY6IokqCFAyUu6kTHGpaCN7BzCEt
 CejG+cUhMdJNt43lYa1IryHT0XIXl7rqM5PCVOCOK+CvlhYZGQ7Sici1QO19sr5d8wKFQVJjfPa
 zd3+8WbNdElsZTqQXxDJ+eH3g9bz9HuyDJMfOc8O+S9UCrCJ6+OJ9mLjL7VY12DT+t/w9mO2DhA
 ySVmnlzLtO8PrgeG6EohRLdxa8FtM0TQ/2F5U+bSiyd0sPSpGppA0dWbitg==
X-Received: by 2002:a05:7301:6908:b0:382:f0d4:1e77 with SMTP id
 5a478bee46e88-38571219f03mr16835629eec.36.1795565219397; 
 Tue, 24 Nov 2026 16:06:59 -0800 (PST)
X-Received: by 2002:a05:7301:6908:b0:382:f0d4:1e77 with SMTP id
 5a478bee46e88-38571219f03mr16835599eec.36.1795565218810; 
 Tue, 24 Nov 2026 16:06:58 -0800 (PST)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c371esm47494708eec.23.2026.11.24.16.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 16:06:58 -0800 (PST)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 05:36:42 +0530
Subject: [PATCH 2/4] misc: fastrpc: add HPASS domain
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-fastrpc-hpass-support-v1-2-cb1d46b29e3b@oss.qualcomm.com>
References: <20261125-fastrpc-hpass-support-v1-0-cb1d46b29e3b@oss.qualcomm.com>
In-Reply-To: <20261125-fastrpc-hpass-support-v1-0-cb1d46b29e3b@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b0626a4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=yezPJc07dsF5jmqqbk4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAwMCBTYWx0ZWRfX6GQVnyALvn9L
 ZPI0Zt2IekfssLOfMV3cg1xbEzRpUUN/WdqpBqMDmYv2+Jopc2GRQ+wJodiP5GmUJ9pGz11KQFo
 Blbcc64iYa3CDBEOBYNeakGzFIQtFgo=
X-Proofpoint-GUID: p56dExFF9_RkjNAqy81caxzxpsC5SDvk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAwMCBTYWx0ZWRfX/1fZAg4LURJw
 hKjOYPYqpBOUoV/USZMyL5aoKyqrjiotxrzMtsWsirRYdfkH+omwwQbtXAHgJE1KscA/84hMyOW
 0/h3+lYAWovL8/4+tUzoM51DVPRnb9b0V2ynr2l71eAZHcEXbj0elwP2YazcjFjMQ64pEC4BQU8
 lFGXhb6dfclkk8ozoSxsmNH4wQGyq39UbBc8v8DZkG3WhoYNu3AOC7lFe+H5/kfsGvPxpDQpnA6
 L3B49k5Ggc0cW3/c9pX3095cz9cUrVpueqrVOreVbuDBrtlP5D0p466FZ3ETrqNxWMDE6c6EVU7
 CNlEs56hkmiemp8EM9LcHl3v4Zwi25nJtazG4/X6GY4T4a/9Vn6qvDo3KhpS3+0kxowq+ke0YHu
 LzHHB662+RC11GrwpyEYbcf74MT9t+0qbuSXuMr1MdA+t9FZZ3e4KGf5Lh7HFUKBauRs2m+VqW3
 PtrG0x43e13UgfBPkZQ==
X-Proofpoint-ORIG-GUID: p56dExFF9_RkjNAqy81caxzxpsC5SDvk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
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
eXtensions), described in the devicetree with its own "hpass" label.
Add a HPASS_DOMAIN_ID and map the "hpass" DT label to it.

Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9e760f68bcaf..c515097c3d3b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -35,6 +35,7 @@
 #define SDSP_DOMAIN_ID (2)
 #define CDSP_DOMAIN_ID (3)
 #define GDSP_DOMAIN_ID (4)
+#define HPASS_DOMAIN_ID (5)
 #define FASTRPC_MAX_SESSIONS	14
 /*
  * Extra ADSP sessions duplicated from the last CB, as each CB supports
@@ -2497,6 +2498,8 @@ static int fastrpc_get_domain_id(const char *domain)
 		return SDSP_DOMAIN_ID;
 	else if (!strncmp(domain, "gdsp", 4))
 		return GDSP_DOMAIN_ID;
+	else if (!strncmp(domain, "hpass", 5))
+		return HPASS_DOMAIN_ID;
 
 	return -EINVAL;
 }
@@ -2655,8 +2658,9 @@ static int fastrpc_init_reserved_mem(struct fastrpc_channel_ctx *cctx,
 	u64 src_perms;
 	int err;
 
-	/* Only SDSP and ADSP domains use a reserved remote heap region */
-	if (domain_id != SDSP_DOMAIN_ID && domain_id != ADSP_DOMAIN_ID)
+	/* Only SDSP, ADSP and HPASS domains use a reserved remote heap region */
+	if (domain_id != SDSP_DOMAIN_ID && domain_id != ADSP_DOMAIN_ID &&
+	    domain_id != HPASS_DOMAIN_ID)
 		return 0;
 
 	err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
@@ -2670,11 +2674,11 @@ static int fastrpc_init_reserved_mem(struct fastrpc_channel_ctx *cctx,
 	}
 
 	/*
-	 * Audio PD (ADSP) is a static PD: cache the region so its lifetime
-	 * is tied to the rpmsg channel instead of being controlled by
-	 * userspace.
+	 * Audio PD (ADSP/HPASS) is a static PD: cache the region so its
+	 * lifetime is tied to the rpmsg channel instead of being controlled
+	 * by userspace.
 	 */
-	if (domain_id == ADSP_DOMAIN_ID) {
+	if (domain_id == ADSP_DOMAIN_ID || domain_id == HPASS_DOMAIN_ID) {
 		cctx->remote_heap_addr = res.start;
 		cctx->remote_heap_size = resource_size(&res);
 
@@ -2761,6 +2765,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	case ADSP_DOMAIN_ID:
 	case MDSP_DOMAIN_ID:
 	case SDSP_DOMAIN_ID:
+	case HPASS_DOMAIN_ID:
 		/* Unsigned PD offloading is only supported on CDSP and GDSP */
 		data->unsigned_support = false;
 		err = fastrpc_device_register(rdev, data, secure_dsp, domain);

-- 
2.34.1

