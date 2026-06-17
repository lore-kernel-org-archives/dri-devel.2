Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5404CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 088FA10EFB1;
	Wed, 17 Jun 2026 11:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MA39vTZI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RwEpXHH7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 311FD10EFB1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:10:04 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8VwRg2056602
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=QZ2mTLAzuiOBLJIxRAjahN
 Qc8qbCeWGYALyMP2niXB0=; b=MA39vTZIq1wL6cmf3l3Vx2BsImGl+anCypF+Vz
 SEVpuUtgSoxlwqlSDbXDrVWge/zZeCp3Q/KfllwmJ7QyUcXziVLsMom45Ktech6j
 JJmr9DFhncXtwgjtz+jrXWdrBNy4nR9H0kMg6x+qBLvJxMyvP22q8mi7PPMeLlX1
 KO7ArEbch2fgCFJ+NvbozKJv+9rd0+rKPkljBUmTLiiR6O3OaQaH8Kk2TQxIbhD0
 zAIxwqPfWtYzK6JEioy5uvJlpuK12/Maz7HOx6qCk3NI65+wwzBIUhAv+fuMH2yZ
 YxzWDhL+DGJPslkEvtzo7Bt27tIjL2X9Q7G7LmSYJTij+l3Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesatpx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:10:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so8601849eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 04:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781694602; x=1782299402;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QZ2mTLAzuiOBLJIxRAjahNQc8qbCeWGYALyMP2niXB0=;
 b=RwEpXHH7nIyfkPTEYOha80/HfUpbdu0JQMA8aVg3iFw9V/TRN3eDYbgVq2Ozp5guh+
 FjS9xfGn+Phr2t1Y1GGmha+wiWhEItXnWZNZTOGkNrcbs3/TrVv3Zn5UY+19fNyLRjH9
 ED/1DMycOdtYje5aZTaAizeetRcZU+1TD74Nteqwz9wUdrckwsxEOKUEpHE6AtCMqsmy
 ujFi5Ij4+eB3IjEstZgQPF0YiBLZ1bM8paEEIm4DgVuRRugaOfeobza0fT2ZPugzZF6N
 79Z2dMhEzsf2Wln4dSXZPi2AryClcMz8jnUkbSB8Oi1eLbUv+z8MpWEs21ZYpE/sHw7q
 SKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781694602; x=1782299402;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZ2mTLAzuiOBLJIxRAjahNQc8qbCeWGYALyMP2niXB0=;
 b=s7IvapFl8GkUN8n7uG/qdHQO93OKZXofw2r8ZLQd0/b41VGGjWuXQi07fumYFBRc9a
 ylfYUyqAvIQRCegMe1YBioEKRfkLFDJJ8FNRsIEoRhhzAM43wRcXKFtvgW4a2mCNbZp3
 0CC6By64hJY2tXfUBQn8BDBPGYJlcH46se0kMqVEuNh6ceAnxCnnkr2PECUvKU7bfD7e
 EaiNlQS9g9q8fmKhaI/rO4en3jqEhrena++2Zs3ePpaqKajivvFGq3rk2wcpGjwVUppk
 ScO8kooIRNTFZ0NFJICJ3qL6wW2IfgGWMuzFoPWEzhphGY+g2fxtDxEalnXmK4qb4nq8
 PEnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ82+dfSURwaPfqqiVwSMtecxR5aTseNPjYJZ+Z8dhAfLslbdI92vTSbTaSmFqkadaQ7LW4F3BuDCRs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwS7m/hT3Ko4S41rKlvLeojVZhut4xKoeMiA/KKZ9Zej42fD3Y5
 G+eCV5yGsxUdRiVGQyaUqwyZRMm6PgX0C+v4t1dNg15ppWfnR3nkBkpMabMfg++5dLmZMAcMrdO
 ycOHEmZK4TogZk96OUj5rGxUzmzGou/hIgogCTdV7Oz46CmHghSI7BA2lA+L56O684mNlPPc=
X-Gm-Gg: AfdE7clIKhy6drFE4n25YqwmJhKJYnnG+0fz0fiD10G8R276HnixUpUgzMBHxxRcxaa
 Ns7roov2CkhUFC+GKhOkkxkCs0Imq0W6pleG+LXKMwLbZEBonklqTXPUh18Xp1hF3eaCam+w6wG
 apbm2UHe658/9vHSzoZ1+83XficJBeJrM1V5jQX65INngwcqukm5fXu3SIAL/xztCw+oKyNim9q
 j1M1+pjasaJk5Zp1VD7eMq6KU/9YV65QvLA5pdfZk+3o9i2qimPfD9Nms80Fm84OKTLY9vbZ0Za
 lcYbhQ8A7FlI6jh9ucuEN99ao9nGhaaxpstsqNfzDBKPgnwkb6LRw7MGLOhTGJxz/M0FxfOSUyB
 yr2nl4AAhHg2QPa1ru3DmVi+rzlVjIzYCf/XazhLTZXZx24DEpmWI+1KpaKg=
X-Received: by 2002:a05:693c:20d2:20b0:30b:e525:4702 with SMTP id
 5a478bee46e88-30be52548e7mr127254eec.12.1781694601916; 
 Wed, 17 Jun 2026 04:10:01 -0700 (PDT)
X-Received: by 2002:a05:693c:20d2:20b0:30b:e525:4702 with SMTP id
 5a478bee46e88-30be52548e7mr127243eec.12.1781694601350; 
 Wed, 17 Jun 2026 04:10:01 -0700 (PDT)
Received: from hu-yutlin-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30bd01b768bsm2426972eec.13.2026.06.17.04.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 04:10:00 -0700 (PDT)
From: Eddie Lin <eddie.lin@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 04:09:50 -0700
Subject: [PATCH v2] misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-fastrpc-cctx-cleanup-v2-1-be87c021114a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAH2AMmoC/4WNQQqDMBBFryKzbiQTRG1XvUdxEcdYU9TYTBSLe
 PdGe4BuPjz4/78N2HhrGG7JBt4slq0bI6hLAtTp8WmEbSKDkiqXOaJoNQc/kSAKq6De6HGeRN0
 2Smpd1KWWEKeTN61dz9tH9WOe65ehcHwdjc5ycP5zehc8en8UCwoUqpTXIssyxJzujjl9z7onN
 wxpDKj2ff8C5msettEAAAA=
X-Change-ID: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Eddie Lin <eddie.lin@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwNSBTYWx0ZWRfX0JPBSY6mowMs
 MIsL8xKI8NTr3zN7I7AYgGwPlPML15CjlIo6dFrSX/+R6ylFxvcFEN2yxnmsz5emMxY6L+5wUm+
 /Zqf4VCUIzlrgq0Xk1kVr+vp5wjV5h0=
X-Proofpoint-ORIG-GUID: IKCiWOatzhkT48Uo8V7YBBzWPYDbRYjr
X-Authority-Analysis: v=2.4 cv=R6oz39RX c=1 sm=1 tr=0 ts=6a32808a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Rsn1OCey0fvCUy5VNe4A:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: IKCiWOatzhkT48Uo8V7YBBzWPYDbRYjr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwNSBTYWx0ZWRfX0PK4qQx96jKD
 v/3mEZk+yAo1WyHdU7+SM5FgAn/eOhqrXsizIroquZ6XziEYiPplc4vNoN9+rP/zbtJDmhV1mcp
 UFzsWyso+mCrY8lf9ASP3iDCctkcBYF9fxjYc0GSnIQ93SDNKo0c/Z1hQB2ykG0+mGaOv1og716
 zMNQY6+5J9Z0RMUeuRsb1ykWnK5sRN7ZMT93WJ1noKZCYnLfmFYuV8qqf9x1xapqsCmbWtO5Q2u
 ibzw5y4s2NRK/ptkPtRq6jG4i0B4Huex97oR3wj29qFgpvPTtvdUmD7v/ENyLRZHH7HicKbrPFt
 LEOCbipGQP4QGi5nLQux6as7AwuaP+Fo0OgD4LA5IVbHdtV4gUXdfqsw3SWVlDwYq9ByGv5Nc9T
 2yDmP4E/pamarICkalYotJbBKr8S7Ybi/R543rn6YUOwZHMe4md8kknsBJH8KTZ08K+faqNc4EY
 c++PW5N7NmEIN2OO/qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170105
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

The 'ctx_idr' is initialized but never destroyed when
the channel context is freed, leading to a memory leak.
Add idr_destroy() to properly clean up the IDR resources.

Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
Cc: stable@vger.kernel.org
Signed-off-by: Eddie Lin <eddie.lin@oss.qualcomm.com>
---
This patch fixes a memory leak in the FastRPC driver by destroying the
IDR associated with the channel context during cleanup.
---
Changes in v2:
- Added Fixes tag.
- Added Cc: stable@vger.kernel.org.
- Removed duplicate description from cover letter.
- Link to v1: https://patch.msgid.link/20260611-fastrpc-cctx-cleanup-v1-1-28097444116c@oss.qualcomm.com
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a9b2ae44c06f..7727850e9240 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -492,6 +492,7 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
 
 	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
 
+	idr_destroy(&cctx->ctx_idr);
 	kfree(cctx);
 }
 

---
base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
change-id: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0

Best regards,
--  
Eddie Lin <eddie.lin@oss.qualcomm.com>

