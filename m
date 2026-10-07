Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F04CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A80B10EA3D;
	Wed,  7 Oct 2026 11:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GBy4QTGY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="URzckK+9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A418B10EA3D
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 11:38:19 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BVGue3687394
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 11:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vMN/dB4ZkEq4ZuEigsZAolrFm+neXQ+47DolAtCQpj4=; b=GBy4QTGYVMDa8gui
 8F6swmaQKc3zd5smFaomemcUJK7oVDYPoI0xn/PEhjz80d+rTjdRTwCrnXOA34Vr
 XlWnZYUm0bziRD+Wowuq7tOfR1RgexndYU7GlFMqNIfrdaL9YxIGchroIx6L9MVQ
 wdeMgqk2OdbjvtN4UIaaJI76tn0RkqHRUs3k/7cKA29KU9Fuxn1LwThrdS9LXIQO
 A4lco8YxJFP7F0NIUrfi8CfKQn/ozYRWXOsFzfG8DpoaVeB/fX5S47pwKwJfx4eQ
 /wH6WV4G2rlNKo67J6pkF7aCI0CWAzuzLsFS+DbF60iARfwyREpvRHscswsba8aE
 ERlNWw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5mgr866e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 11:38:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e61a48d5b7so2139935ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 04:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791373098; x=1791977898;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vMN/dB4ZkEq4ZuEigsZAolrFm+neXQ+47DolAtCQpj4=;
 b=URzckK+9ey58WW4caV1wIBJtzuVM7bz/JCPR+v6BF1dmqWaAqL/4RhPQFLyy+y5I85
 NNLRQft3gANrGTXN6MRhQ7746EBD7hZMytcm+TseHSFh7xODU7ypcrFz6nSc6tOiVR79
 W6IH0qJ/wBy/dFsL3vHec8l1wY+SNRs14bag/EfVtnQNMbvnQ4zXSRrKI2RSkJO/Df02
 ZzqG+zyHKAiUt/e7NgDJ7KgXPgsbBIWUvrl0PCGQV4y0p0kJLFravnlcSbePe0/spUoN
 TnT/f3kvAmwhrYWhgTxrGIzdAvld+/RZLnXEEdCEu7lPQMUZroOZNynZ2KMAxA+YrtN3
 SH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791373098; x=1791977898;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vMN/dB4ZkEq4ZuEigsZAolrFm+neXQ+47DolAtCQpj4=;
 b=W2sa1YrH7ctMtr6jPBk1Tqg37rKEUqKDoQQ5A2SVm938fjGJzABbJN7gQ0ANyG3UXT
 Fd/5wJc4cRy7W3HyeXbTo5eMrDjcbX0qJEXuYm0QCU81k14kzKwTygK2hTNyAmVyoR3G
 PGhBxwVEzpLaLfUTWGp+E6a71sGBrsMphdu+LW988YAKSyFJxJsP2vxlSQThR5GmhTSq
 znjAtSOuvc67C8iW8UG67vnepT6txQ5xKWLAi6/bat06+3NF+Eb1bh0Wc9wWgivUD6b4
 1NPIcT7TgogD8oPUrBmmeccgpbD8+9wbDUZRhO1etLRFHO+yjiCiYMyP8trP7ysMJmfS
 zLVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFeY/SdVA2LN96cBS7I8z+EDppM8xOjbzzuuf9wLIVZbmniwjH/myNq5/w/nYC5oqbD1jmrByvw34=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKlBsUdmFgSB/l8OdLbBNlNOSz7hAZ3/PCIoD4Movz/bDHRivKo
 cjKLtS9h63/Pb9ZjYD1UZ+mxqYlujd3t+7o4qYbQtf5SFPF9doQatXRO/7EEwD/inyj5Z7/5ttJ
 Wxj7Hp9dFmGbDunkRWzkkkhICXtD8qkyEl6aPoXaXr+TTu/6nmnx1sxRAS7vDfHeLvIOPv3Kj/c
 n6HcA=
X-Gm-Gg: AYBFou1Ti7YdPBgkzdBgQn5X3neeWIQ9vVDgnWudlXQGbiRPTsZOvl8iGKen/H8m4Vy
 IhXakAFw2GYxScM+++4lNYG4qBAp7v44QrU70wDFmuWZ+ZNUclFFezFl6v+vYwdc0Aa6pTWV/xW
 Iao/1cwkcUqkZ9iAkCEivCXFucJkWaUwmkfuSMkYfr1owtz+nYi2HTaN6Spxkew7E9+7A8aj1NN
 zrUlh9LbBWfyTPfx8CsEmmIGl7Zw2midAkZg5QEZ1OYEA/TQ45xSwYst1IiQOJ44tiTtxeQRleW
 VveUbMGqoAfKNkLTaIWjIiCOGt8Idnc5l687kKaGRzSmQXnX+iwZ4Q4TsySbc+/99nLGCIt0JHz
 KF50mH0PSCa9ZBOpXKBDj0muVY2T9EWE/
X-Received: by 2002:a17:90b:4b8d:b0:39e:6c68:fd91 with SMTP id
 98e67ed59e1d1-3a8a1569ab3mr1107956a91.38.1791373097701; 
 Wed, 07 Oct 2026 04:38:17 -0700 (PDT)
X-Received: by 2002:a17:90b:4b8d:b0:39e:6c68:fd91 with SMTP id
 98e67ed59e1d1-3a8a1569ab3mr1107943a91.38.1791373097155; 
 Wed, 07 Oct 2026 04:38:17 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a8a5e0eeb6sm1454001a91.2.2026.10.07.04.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 04:38:16 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 17:07:49 +0530
Subject: [PATCH v2 2/4] misc: fastrpc: handle multi-cell reg in context
 bank probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-extended-mapping-v2-2-5dca3aa2c2d3@oss.qualcomm.com>
References: <20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com>
In-Reply-To: <20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791373080; l=1169;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=gGD419HTG2YpsaHNWK2vNobX0Re5xBVQ3uFHDD/+SiU=;
 b=90TJaGDgNrl6dlM0/JPg8Mf4kKYytQP3bL9Qe+l+GIxIRzkUfSCjcUANnGLpy6fm9kNBZCWSb
 3ODYMHKxMpsCFjRZqNkTgp/MnPK8wHPv5693P266MSp6p0LTOzg6WMk
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX+rnfBDmroHKw
 VJlDR4mxPx4Gbv1bInVoNUlCcaxUI6KRCTWeiuJaEK4W6J+8emDD7e6965goW6lWoWXEfYlQ9Pl
 nNoVUPgh4aJU87mEqvWo7MEq/NneiBweHiCaHvlo3lshM/dw04xNpxuEr8XdMA6/pgWzqhnK5HP
 Z6a7k0xlgm86NVtBtw1W2/cZxiJRYCiPSFzitJyCwlJl/U2IVmc0q06ouVUBpQ7NVzEQKr2HmyZ
 4enGPT+JilsIPT16EDf+CrauYydedMZhdUimnITeTc0bclPPJbqUb8ZF4bdUeBoekd69MwBw35I
 O/RHaGkjdX++PsWdNQchz6vIxWVL53Ule7j+473+6nwKSrEa/DbXB+rMAN+DfIOeXdHZztihFHc
 Ro1CLr0bJx4OAn2czkT5waML8E+SxaULlI2toCsky6jIYU/8BWxcQ2RZg5QKPE3PBEV0XhxwiYq
 uba9XK28dORUpz0R/zQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX+vRGM0sH0x/s
 uneSNIjUG2QS3hBsxRYdhYwQh2qzr3oiAx452X9LBErx2/AT2pGVpqY1W+cIfyk+80PysOrXwPx
 ihA0VbCJRPT//N//3qc8ijW6xifQeDM=
X-Proofpoint-ORIG-GUID: WHyL5aQXTySzeQ11X6pGnxfsPDFmMdRK
X-Proofpoint-GUID: WHyL5aQXTySzeQ11X6pGnxfsPDFmMdRK
X-Authority-Analysis: v=2.4 cv=OYkNnRTY c=1 sm=1 tr=0 ts=6ac62f2a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=OuqQISpc-kSra7OiYdkA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046
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

Platforms that use #address-cells = <2> on the fastrpc node encode the
context bank number in cell[1] of the reg property rather than cell[0].
Reading cell[0] on such platforms yields 0 for every context bank,
causing all sessions to share SID 0 and corrupting IOVA address
construction.

Use of_property_read_u32_index() with of_n_addr_cells() - 1 as the
index so the correct cell is read regardless of the parent address cell
width.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index b29c1fd00de2..5c7bb56cf46d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2348,7 +2348,8 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	if (!cctx)
 		return -EINVAL;
 
-	if (of_property_read_u32(dev->of_node, "reg", &sid))
+	if (of_property_read_u32_index(dev->of_node, "reg",
+				       of_n_addr_cells(dev->of_node) - 1, &sid))
 		dev_info(dev, "FastRPC Session ID not specified in DT\n");
 
 	spin_lock_irqsave(&cctx->lock, flags);

-- 
2.34.1

