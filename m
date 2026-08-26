Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79966C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFFF110ED46;
	Wed, 26 Aug 2026 13:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/zMGxU7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QJi41KTm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E65A910ED46
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:32 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCCH0T1223169
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8JBRtmRYqTLQMALZTMnqF/HwOuWRZCxhN9n2QVCbJ84=; b=L/zMGxU72sIuAhNS
 jnYXA7EJCfh594Ri2B7JC57Hevzcy64o2QhcNsSgiH10SiGiZf6BF+q75wLK4Oet
 w2MoX8oLAXwD/q3DcByk90W8hojBWQ360s0uxxblOpAzWQ56esR2hQnR48unonwQ
 TiUM0jFPy2qGBv2TW3FoZhCTBgsdxD7YlH+rbZ/qKCXHfwwCRw66GxkpquqAm0mf
 7N+XBzkKiYz/lOGotMaHiMuFmAXJpO+Aaj2uThyJ2RZ1evZNGyHbGzGzxjQ6N90A
 z+eqdm54w6aMWSnicl9n+4P5zayNohLXTzqhMLlbXISDt5kHtVKTk4BJSk9JIret
 gdXHRw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r1gjb04-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3965ba1ba3eso1353006a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787751991; x=1788356791;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8JBRtmRYqTLQMALZTMnqF/HwOuWRZCxhN9n2QVCbJ84=;
 b=QJi41KTm98XSIUGYrt3+R0keW4QKuK0gODpAXoRXOnQl6SSsAYD/p8FcCFVXMxKVoj
 Me3SOrcsWjKK4HZATgilbUUGbaSwY0PjrW4Upf2UsDE5sbqFHPIvLz4wGkmtR8g8Y640
 EvR4JwonAntx3a9H1c4zLtZzCX5npoyEdhylDrZ0qznqQvH/h3koeqvxiGkUBcoJrMsW
 7gyfGWwiMAlFrT1XBKRWQTXOzX2LY38NZ2OhqBQmQwxWkP+2taDSR+aC/Yl7tOg75Xwa
 xkqZcxBidZf5QkZuM+jnSQHs6FHGcNxxDRjGBgMUBo23InCBqRRdKxvcH0XxKkxyyNnH
 KwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787751991; x=1788356791;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8JBRtmRYqTLQMALZTMnqF/HwOuWRZCxhN9n2QVCbJ84=;
 b=mow+x4sonoaLHXp/dccgS8n5d8yyGr2retmvKAFqBAaIoZYveomiORHsMdJdwNsHB8
 Xmlp1LZfhn2rwz52qxZKiXQBUgInqCFH+yn/ArG7DSLHrsStORysdhtpIXJxBtxVVygE
 pxOJtF3iM02RG1ELk7xzjDSWjYZ1SqTDm+hYWwWq/YaqyyS30HDJ9cNN5hjQP1q+7Txz
 AhOSMRGdpp5jrYMR70LJO0PYQLJTt6dvy1W7DAPPASBfjcLYF8k06TDunOlc4viVqiYW
 XV2hHx9NUTkjtXymjbrs2i0RFg4+suw1eESIOZq4fQgdAhTHgodwNxPZNGSGxpDynN0k
 l4MQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJOXcZSj3/DZrdQRWaGXboLHj4bDv0RPzvHcqgrBhgqsYcNvKhB9s4BW8BposQXQBXfhdYhH3DEoY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mQxS6U8hWq0KPoRRe+HvLFObuJTGwdRtWNNFF+da2PvFv0GluJ
 o9dzSnrqleFueOVyL47P8HfOOhW+VipciBIpOu64ulBN5dO2cVsHIdVzMyZpkZqd8Yq1Db5hCpK
 zXGkGSUtaVLO5k1t2adb804JweWoQnV8gn1rTkBy5V04lWvAOPxPLfoWzCuKOK/52ZQdUUhU=
X-Gm-Gg: AR+sD11HoGipFo3RaUvel06yQM2U0uJbr9Ti6yrUnKQxN+zEWe/QJCp9g+9jSyZM3ZK
 PLhQmfd3mm2zHoosCChhW0EgLEB6Bb2x4uKH/bnALVPFlwyGPnJyFLz6bWipnqZQPHNeYeWhHzG
 RGfqVZBU7mAH4lkiLzoc+o4wfnivboG/ppvJjI+pOm894AWRkhfx+Fktcu7FplZvUrPG97xcg0W
 SocKwZRA63YXUL0QUUy0amUccW9OTU/hWfD2/atwke1+U/5EqJxo9oGMc+zxkqjZr56R4scz1Us
 AE5WWN85rO880Jph3kxXH9ShwD6Xzr5MO8R79xVcrTJLEKFA7eizxVwUkfhJ3/25scq45HNaxLx
 NBNEO8AnmLTkR+QwXl4BFWVXVLg8Bzb6ZcQ==
X-Received: by 2002:a17:90b:5107:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-3966d9e5ecfmr15275581a91.15.1787751990782; 
 Wed, 26 Aug 2026 06:46:30 -0700 (PDT)
X-Received: by 2002:a17:90b:5107:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-3966d9e5ecfmr15275446a91.15.1787751990244; 
 Wed, 26 Aug 2026 06:46:30 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b64c48sm8179696a91.8.2026.08.26.06.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:46:29 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:15:48 +0530
Subject: [PATCH 6/6] misc: fastrpc: Add UAPI flags for extended IOVA
 mapping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260826-extended-mapping-v1-6-d046c1cb9a9f@oss.qualcomm.com>
References: <20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com>
In-Reply-To: <20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787751952; l=7568;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=uiIZuwO5p10QZ2Fwu25eLmhT5zkNnRxyXBK90PHFhnA=;
 b=b9udi084KNRmlYbIeP6jwnTsfea6wsIxWybCbnvzc3OJEpkNRvRxvT676jCz9Zl/51wnZtShH
 BywBCrbVmaCC8yx4DC4zE6Zj8lLW7OBzdu0KQfIiabVk2v/fDo5EVbW
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-GUID: H_dO3pxXofAd0vRiQJbPSgXq1cTMr10_
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=6a8eee37 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=jcsToSEUEPbHcpESBJIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExNCBTYWx0ZWRfX8sL9Hp20C1uG
 sSwD01fN/XuprPs9f9aKrS1LMIAhAeB0wZK06Asz45Ry72LNMp1DR/8MUZDZS95EU2jJFocfjhP
 KB1EfQSp+WLKXoNwalFrVKJwzxXY3JI=
X-Proofpoint-ORIG-GUID: H_dO3pxXofAd0vRiQJbPSgXq1cTMr10_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExNCBTYWx0ZWRfX004kr2Cr6sQD
 E+gUvNzXxp4Gi+Zd9XDdsJhN1IZnxcsZKsI0KP87to6UOhbk9Zd2wcR3+ZeCn7dpsfY4Y5YT7mb
 DEXA/+ALhZTxiNP9iajssAYh829oick75RH0QOpo9IeCSx7ZMhE8ODOnGpIY2FxyVm/wePyVcVz
 bYGzijb2NrgFzagy/6qAx1RtAQqlbJas0aIuLeYL/GZR0NMXxzb4my69OFqwPeencjy/p6eWCw4
 jfAQl4p1hyWstgc4N9jJpzlqSSssggW9+Y94Tmu4kBTeRDZktp+rk4RZRR7/oIa6bhV81KcWOlc
 2DVKjZpLHy+fZaY9rDc6mer/XXGWDNVZgTG9F/V+V5r0ZufMHZVvvDAPUUYGq0lHLFPkZBCMLT8
 XD4Fwgtdm70buqKummvWsLruxF/UEv+5nHSnNMwAwokZURssWi8ZwhRTpVV6aA88HVFLEyWVX76
 43x1Lw36oLJ/APtUusw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260114
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

Userspace has no way to request that a buffer be mapped through the
extended context bank, so large buffers cannot be placed in the wider
IOVA window even when one is available.

Add two UAPI flags:

  FASTRPC_MAP_FD_EXTENDED         - map immediately via the extended CB
  FASTRPC_MAP_FD_DELAYED_EXTENDED - map on demand via the extended CB

When either flag is set, fastrpc_map_attach() iterates cctx->ext_cb[]
and retries on -ENOMEM, falling over to the next extended CB when one
exhausts its IOVA space. The SID offset passed to the DSP must reflect
the actual CB used, so fastrpc_compute_dma_addr() takes an explicit
session rather than always using fl->sctx — without this the DSP would
fault on access. All existing call sites pass flags=0 and are unaffected.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c      | 64 +++++++++++++++++++++++++++++++++------------
 include/uapi/misc/fastrpc.h |  7 +++++
 2 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 28d89fd9cbbc..2f248667e734 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -83,6 +83,11 @@
 #define FASTRPC_MAX_DSP_ATTRIBUTES (256)
 #define FASTRPC_MAX_DSP_ATTRIBUTES_LEN (sizeof(u32) * FASTRPC_MAX_DSP_ATTRIBUTES)
 
+/* Check if the given flag is used for extended UDMA mapping */
+#define IS_EXTENDED_MAP_FLAG(flag) \
+	((flag) == FASTRPC_MAP_FD_EXTENDED || \
+	 (flag) == FASTRPC_MAP_FD_DELAYED_EXTENDED)
+
 /* Retrives number of input buffers from the scalars parameter */
 #define REMOTE_SCALARS_INBUFS(sc)	(((sc) >> 16) & 0x0ff)
 
@@ -880,16 +885,19 @@ static const struct dma_buf_ops fastrpc_dma_buf_ops = {
 	.release = fastrpc_release,
 };
 
-static dma_addr_t fastrpc_compute_dma_addr(struct fastrpc_user *fl, dma_addr_t sg_dma_addr)
+static dma_addr_t fastrpc_compute_dma_addr(struct fastrpc_user *fl, dma_addr_t sg_dma_addr,
+					   struct fastrpc_session_ctx *sess)
 {
-	return sg_dma_addr + fastrpc_sid_offset(fl->cctx, fl->sctx);
+	return sg_dma_addr + fastrpc_sid_offset(fl->cctx, sess);
 }
 
-static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
-			      u64 len, u32 attr, struct fastrpc_map **ppmap)
+static int fastrpc_map_attach_to_dev(struct fastrpc_user *fl, int fd,
+				     u64 len, u32 attr,
+				     struct fastrpc_session_ctx *sess,
+				     struct fastrpc_map **ppmap)
 {
-	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
+	struct device *dev = sess->dev;
 	struct sg_table *table;
 	struct scatterlist *sgl = NULL;
 	int err = 0, sgl_index = 0;
@@ -909,9 +917,9 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 		goto get_err;
 	}
 
-	map->attach = dma_buf_attach(map->buf, sess->dev);
+	map->attach = dma_buf_attach(map->buf, dev);
 	if (IS_ERR(map->attach)) {
-		dev_err(sess->dev, "Failed to attach dmabuf\n");
+		dev_err(dev, "Failed to attach dmabuf\n");
 		err = PTR_ERR(map->attach);
 		goto attach_err;
 	}
@@ -926,12 +934,13 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 	if (attr & FASTRPC_ATTR_SECUREMAP)
 		map->dma_addr = sg_phys(map->table->sgl);
 	else
-		map->dma_addr = fastrpc_compute_dma_addr(fl, sg_dma_address(map->table->sgl));
+		map->dma_addr = fastrpc_compute_dma_addr(fl, sg_dma_address(map->table->sgl), sess);
 	for_each_sg(map->table->sgl, sgl, map->table->nents,
 		sgl_index)
 		map->size += sg_dma_len(sgl);
+
 	if (len > map->size) {
-		dev_dbg(sess->dev, "Bad size passed len 0x%llx map size 0x%llx\n",
+		dev_dbg(dev, "Bad size passed len 0x%llx map size 0x%llx\n",
 				len, map->size);
 		err = -EINVAL;
 		goto map_err;
@@ -954,7 +963,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 		map->attr = attr;
 		err = qcom_scm_assign_mem(map->dma_addr, (u64)map->len, &src_perms, dst_perms, 2);
 		if (err) {
-			dev_err(sess->dev,
+			dev_err(dev,
 				"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
 				&map->dma_addr, map->len, err);
 			goto map_err;
@@ -977,13 +986,36 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 	return err;
 }
 
+static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
+			      u64 len, u32 attr, u32 flags, struct fastrpc_map **ppmap)
+{
+	if (IS_EXTENDED_MAP_FLAG(flags)) {
+		int i, err = -ENODEV;
+
+		if (!fl->cctx->ext_cb_count) {
+			dev_err(fl->sctx->dev, "no extended context bank found\n");
+			return -ENODEV;
+		}
+
+		for (i = 0; i < fl->cctx->ext_cb_count; i++) {
+			err = fastrpc_map_attach_to_dev(fl, fd, len, attr,
+							fl->cctx->ext_cb[i], ppmap);
+			if (err != -ENOMEM)
+				break;
+		}
+		return err;
+	}
+
+	return fastrpc_map_attach_to_dev(fl, fd, len, attr, fl->sctx, ppmap);
+}
+
 static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
-			      u64 len, u32 attr, struct fastrpc_map **ppmap)
+			      u64 len, u32 attr, u32 flags, struct fastrpc_map **ppmap)
 {
 	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
 		return 0;
 
-	return fastrpc_map_attach(fl, fd, len, attr, ppmap);
+	return fastrpc_map_attach(fl, fd, len, attr, flags, ppmap);
 }
 
 /*
@@ -1061,10 +1093,10 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
 
 		if (i < ctx->nbufs)
 			err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
-				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
+				 ctx->args[i].length, ctx->args[i].attr, 0, &ctx->maps[i]);
 		else
 			err = fastrpc_map_attach(ctx->fl, ctx->args[i].fd,
-				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
+				 ctx->args[i].length, ctx->args[i].attr, 0, &ctx->maps[i]);
 		if (err) {
 			dev_err(dev, "Error Creating map %d\n", err);
 			return -EINVAL;
@@ -1628,7 +1660,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	fl->pd = USER_PD;
 
 	if (init.filelen && init.filefd) {
-		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map);
+		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, 0, &map);
 		if (err)
 			goto err;
 	}
@@ -2251,7 +2283,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 		return -EFAULT;
 
 	/* create SMMU mapping */
-	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map);
+	err = fastrpc_map_create(fl, req.fd, req.length, 0, req.flags, &map);
 	if (err) {
 		dev_err(dev, "failed to map buffer, fd = %d\n", req.fd);
 		return err;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index ba1ea5ed426c..b39c0e197a45 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -36,6 +36,11 @@
  * cache maintenance for the buffer.
  * @FASTRPC_MAP_FD_NOMAP: This flag is used to skip CPU mapping,
  * otherwise behaves similar to FASTRPC_MAP_FD_DELAYED flag.
+ * @FASTRPC_MAP_FD_EXTENDED: Map buffer in extended SMMU IOVA space (16GB - 1TB)
+ * and DSP VA space (4GB - 512GB). Can be accessed only through uDMA.
+ * @FASTRPC_MAP_FD_DELAYED_EXTENDED: Map buffer in extended SMMU IOVA space
+ * (16GB - 1TB) but skip DSP mapping. DSP mapping will be done later by
+ * the user. Can be accessed only through uDMA.
  * @FASTRPC_MAP_MAX: max count for flags
  *
  */
@@ -45,6 +50,8 @@ enum fastrpc_map_flags {
 	FASTRPC_MAP_FD = 2,
 	FASTRPC_MAP_FD_DELAYED,
 	FASTRPC_MAP_FD_NOMAP = 16,
+	FASTRPC_MAP_FD_EXTENDED,
+	FASTRPC_MAP_FD_DELAYED_EXTENDED,
 	FASTRPC_MAP_MAX,
 };
 

-- 
2.34.1

