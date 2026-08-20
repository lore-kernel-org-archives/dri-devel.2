Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A240C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4666A10E125;
	Thu, 20 Aug 2026 04:44:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oqg64kbl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CEMXy7P6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716B410E125
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 04:44:31 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JL8TFw1458722
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 04:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4YowyjfOG9pQiJVkE66VCvqOZqFDnt2tLDraq/jeeko=; b=Oqg64kblkgDE9hM+
 5R3gEXL6b2PwZeH7sTYv+rflEPuOfHtuPlgqgtIlyTidJd7zDARS8qKhipyqQ37S
 /A1W24mvxmALJ7exMbU6+CdVsb+8KcTawjYrKtZ3o2k3XqnNfjNIRs/ilOfC01oE
 1t9a22Kr4jdj+L6NdPUMnrEpzPxgkr35MxZ0n+PNhjEloqePxZKk8Yp9/AnI6rj0
 GS3X+MYoI/qkjXskgFPVVrT1veiqgl5L/UCrwf3B1PgKmLJQx+oI0u57Ef7raNZq
 g0RdqqUGQbTRF7lgO7+dqpWrwrushcA+yjeMdlKBM9h8zr1utauJTs19h5n6imS0
 APeQ0g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es4b38v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 04:44:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3950b1371a7so2703984a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 21:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787201069; x=1787805869;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4YowyjfOG9pQiJVkE66VCvqOZqFDnt2tLDraq/jeeko=;
 b=CEMXy7P65uktruBiCe0zkNBuPczkgn5Xf4fkBitL0+iBBQOpUJAgaEw5t1bvk0nBtt
 3nQr5d56pw9jUjbGRnqiKqN89607wh5JnLB4d/mEGjFFCKVFOPXxPgx86/+qRXHkT9Ig
 KkYGe1cFgGsBpGoT0esYypwPaDnqtdGOWsRxLW3l4Mmp5imB5t0kSSOxGFN6dlB3vB19
 SLaELPfgq7o4GT7FqMoldN1l9gASIA6/fEfvn0GKgZBxGlUMlTJtKAasZhOo4xe7A3Cr
 vhiduMs6I43K8XSXLCL68U1nZVdYmujf9a5HnNEnmzBfRqtr6VX6TVv9iaXlVrfLeqw1
 YUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787201069; x=1787805869;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4YowyjfOG9pQiJVkE66VCvqOZqFDnt2tLDraq/jeeko=;
 b=cs9AR71i7I7cfSjheCVxopYz4iWQjY61mZTtsGCIwcqAnUF5oiSkwXk6VuPE98jBez
 WGHd55hLBRa/Fuwl86L4oOnrHrda26zNTm7YR8HqnBj9d0Z4TEL6irZ+re1djFz4YKvF
 rbLVcHQmZceUrlcezR4glVWfbFZcDxqnH+2b6JBDEduZSXTrHVWwwQHUwmR5miJKEPq0
 IOTki89T57i2YS0fKgERtvWi88TE+MYgok7Tzy55coHfw+GS3p1Gj5uso2XJo3mQ+NdI
 1R1ps3knZoSHfCwI1Z/QUQjTFu/iB1eTQ/hJhJW6qWelE2BxhiOhJlMkMoq2rCfWcQ75
 OILg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3XNu8dc1ncvoLxaEtFm1rQE/VwHhlMtvEOcZoDLd7mq59xGpBjaNS8CVS6/xpRV2/POiu3LoiGao=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kqjwdeGlMknR4C5A2v4c4V6/EvyAHCo7WDXZjoLWy1Ayd6Qck5
 IKP176qnaqR5gDL+CazzFzT1AmZKFMAcPiYWQH2BxqcDSfoU6KHaveY5kYmnU06/gED8VReVTFr
 XKuvilvkAOtsCZBMY/HXYa/CkyGlr64dz3oWyYQ7Bp8gH0YtP67HX2SKY/OTkJ34ZdZpMhPQ=
X-Gm-Gg: AR+sD12+BvDWN9UMRsj7oDiw2IDBsWFseWlw2ac4T/u4o5fKfXIjymFhDpE0qVvbEpk
 iJjf4kU4CRVgOwlr9LLNWS7LELkOQ9REOSjTOL2BV4rHFMOE2R0lT8L8EKX193xL1zgEWcVYra1
 C0tJ5BOf3Nt+w0KHBPmLm/Q4AXjudESPkFNbhsFUaCz3uUezjk9qf4b1hq6pTgOgq6YiZfYYMEd
 f47QhFGU4Sv8abP3++nFg6AXY5D05TQiZgWXP7amzKsy496RG24tKtZ4KSLhoezmFjJzkltK252
 +HFYm31Tl7O10Q+YgBKxcut8UvoUYY5Z96PHgL4FhFYTICTT9A5eiZCBGYueCVDndfratV2Udya
 +6xqS8sXPgY1NPAaqwlDNpJPQSTPNAg==
X-Received: by 2002:a17:90b:2f06:b0:37f:e177:f58 with SMTP id
 98e67ed59e1d1-3958108a0f9mr19146125a91.9.1787201069219; 
 Wed, 19 Aug 2026 21:44:29 -0700 (PDT)
X-Received: by 2002:a17:90b:2f06:b0:37f:e177:f58 with SMTP id
 98e67ed59e1d1-3958108a0f9mr19146062a91.9.1787201068747; 
 Wed, 19 Aug 2026 21:44:28 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef7a0easm14338932eec.12.2026.08.19.21.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 21:44:28 -0700 (PDT)
Message-ID: <bf82477a-22c3-45d9-8e0d-ffd4f054b5b3@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 10:14:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fastrpc: fix double-free in fastrpc_map_attach()
 error path
To: Yifei Gao <gyf161023@gmail.com>, Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abelvesa@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260806235056.456341-1-gyf161023@gmail.com>
 <20260811225102.1077841-1-gyf161023@gmail.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260811225102.1077841-1-gyf161023@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dOiImCe471mmIRUFfMMESdtqRAkpMHN7
X-Authority-Analysis: v=2.4 cv=PZXPQChd c=1 sm=1 tr=0 ts=6a86862e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=GpFdYKwLFXUddJV2vI0A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAzMSBTYWx0ZWRfX4RTsduvvZ7jP
 PJ2TQ862raOH11AXYyQeYSanHd/NHmfdlulwksofKB6JbQMP3BKecXerhW5MjZgRL123W5gM8cE
 T3WsmRCU6XxAZ+Du89EbHoifp7jY7nc=
X-Proofpoint-GUID: dOiImCe471mmIRUFfMMESdtqRAkpMHN7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAzMSBTYWx0ZWRfX178bsa18/Tah
 eVxTe3Uqf0JhbOAeeQUK9dgu99mi/kq+7R1vmCitsDXDqxZaR9llmDFG/l0Wz6V3cxLzXClszfc
 n1Zwy7V6BJ25GOlKl2viQUC665ezJDMjlXYwWvuzMaHlKWJHW5w3siI/RcTYQob2wa7Wo7L2Yx+
 dn0cQ6gsE0UgRiHYOtoQdTOIB9yuH7ST8ZAxstf4iqpPsjyIAJsK9fPECxHH55U3FfNpEaHpzAP
 ZxFijDM+siUSWYv5aVSK/bHjP9DocMY/Cp5fWj5KKWSdZjSbbqSsPkP3Yx38w7ZRkNH5oUt7YjK
 EvaSE4Q6sRqyTpnxhwREbJkPhhjcA0Tjo3H8gcoVT6iIsdgznymOOCA4E68GZsKiipi1A59qKNm
 +9+PeZkXgO0Lyje0B6SvZHC9jYC5bN4hTWXiZVjVUHLYHcI6RwmPMHHuF4eTvZJMsMLBCzeeGNy
 /ruHM+fMyolCAGstszA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200031
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

On 12-08-2026 04:21, Yifei Gao wrote:
> map->table is assigned right after dma_buf_map_attachment_unlocked()
> succeeds. The two failure checks that follow, the len > map->size test
> and, where subsystem VMIDs are configured, a failed qcom_scm_assign_mem(),
> jump to map_err with map->table already set.
> 
> map_err manually calls dma_buf_detach() and dma_buf_put() and then falls
> through to fastrpc_map_put(). Since that change the error path tail is
> fastrpc_map_put() -> fastrpc_free_map(), and fastrpc_free_map() already
> unmaps, detaches and puts the dma-buf whenever map->table is set.
> The two operations therefore run twice: the second dma_buf_put() drops an
> extra reference on map->buf, and dma_buf_unmap_attachment_unlocked()
> dereferences the map->attach already freed by the manual dma_buf_detach().
> kref_init() sets the refcount to 1 with no intervening get, so the final
> fastrpc_map_put() frees the map synchronously and the redundant cleanup is
> deterministic.
> 
> The len > map->size branch is reachable by an unprivileged process via
> FASTRPC_IOCTL_MEM_MAP with an fd whose dma-buf is smaller than the
> requested length, before any DSP invocation.
> 
> Route both map->table-is-set failure branches to get_err instead of
> map_err, so fastrpc_free_map() is the single owner of the
> unmap/detach/put sequence. map_err is retained for the
> dma_buf_map_attachment_unlocked() failure, which is reached with
> map->table still NULL and an attachment that fastrpc_free_map() will not
> clean up, so its dma_buf_detach()/dma_buf_put() must still run manually.
> 
> Fixes: 334f1a1cbe03 ("misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Yifei Gao <gyf161023@gmail.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
