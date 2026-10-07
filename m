Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8A9CA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 048CC10E41F;
	Wed,  7 Oct 2026 09:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fb.com header.i=@fb.com header.b="lKIrOAUs";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3EC910E41F
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 09:19:36 +0000 (UTC)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977imAR3372905; Wed, 7 Oct 2026 02:19:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pps82601-s2048-2026-q3; bh=mX2qf44RKus
 dKKqzjfF89Sze+RRKoXcSpRRb/6+EfTU=; b=lKIrOAUsXaGb60G/mwVnszWF59u
 qrHeZIudHnYW1Z39QsilYNXlIegwzHsCwyc1W8anMYzGAEp/xlJPBKfB2ze0/Kgi
 HRqJ5hOs6DXx6xwSfVprfZDjmkVo8sQRS25RDOJUgHiUysFF2gklEdXnLV8Drz88
 qiYrIQseKvjeZdQkixmCL47AOjHSN8uVagTWG9jHbzfGq/3eEzS/XSZLE25eE9l6
 A2mXdApaGLUCfUybXaLZ2GMGQd/imFV4Wmm+8C0rbfjtMjQf/nVsDQBkAd5hh0rZ
 XAyx6I1G6JgW4kyllNUNexobuBsuarb7f6E/s2HtAi0of/Pl9FIF14tHDOw==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h583ecem8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 07 Oct 2026 02:19:29 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 7 Oct 2026 09:19:27 +0000
Date: Wed, 7 Oct 2026 02:19:21 -0700
From: Alex Mastro <amastro@fb.com>
To: Matt Evans <matt@ozlabs.org>
CC: Sumit Semwal <sumit.semwal@linaro.org>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Zack
 Rusin <zack.rusin@broadcom.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH] dma-buf: Annul dmabuf->file on file release
Message-ID: <asYOmaPqwUOBdz0x@devgpu015.cco6.facebook.com>
References: <f8efaabd-c06e-4f04-8cfa-489c148e37ba@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f8efaabd-c06e-4f04-8cfa-489c148e37ba@ozlabs.org>
X-Originating-IP: [2620:10d:c0a8:1b::2d]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzNiBTYWx0ZWRfX+vJYBhXUYmhs
 cv+xUVskw4JIILxt4Amt+pntO7ktJwjjQosy0Z1h2yJuOUigKF8RiX8WyiMVAqcHscj35zl++f0
 U9uVpXkoFO6JxwKKb+4np7jgsGlyWKvX4CMjnBzi/zEgWMFth9s6psfnekUGqYUppAFIm+F1GSN
 /l+JSRF/jXV3g5xqB1SNqkGhbN75LBTs7Q50th3U/687qlbTjTWBd5nK1quHzmX6rFbuMjxXHLW
 nvfzxyjU3OfY5Kw6Wzp0k4bF49dX69SQvQlcoHtANoVk7CTjJ/PsorzUIicZte6x5xYqmR82oYD
 RCGGP9CvwQmFr5iwt7MUy77QsgXiC1qDwf6J+Mm6thMm/vILmw0uH9rNt/7CKv1zb8Iswu3+lXg
 6vg2/3ED9g0pGzpGX++XhEkgdTxIBBhfMBJbzIvEC9Y64FIMdzGM6Me26mYZBYiG/gs8Cd+Y1RE
 ao5wp5uJ7UHkXDav/Pw==
X-Authority-Analysis: v=2.4 cv=Wra+otfv c=1 sm=1 tr=0 ts=6ac60ea1 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22 a=pdWumD2k_P0FcMEzwbQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzNiBTYWx0ZWRfX9t0PuspR+KhH
 1eUyNtJZzddfFvAR7Ybh1v5HbIFiRapntHrGSTA8y/waprEJwPuZTFSvWbTYAJjTlfGIRMdWYlq
 vq06Y/rW4HpeZS16CKOfzlST5KqKT1k=
X-Proofpoint-ORIG-GUID: eeg3tIBh4UNsmIQOofeGo3RaPc7dgsEE
X-Proofpoint-GUID: eeg3tIBh4UNsmIQOofeGo3RaPc7dgsEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
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

On Tue, Oct 06, 2026 at 08:15:26PM +0100, Matt Evans wrote:
>  static int dma_buf_file_release(struct inode *inode, struct file *file)
>  {
> +	struct dma_buf *dmabuf = file->private_data;

I think dmabuf can be NULL here if the dmabuf allocation fails during
dma_buf_export().

> +
>  	if (!is_dma_buf_file(file))
>  		return -EINVAL;
> -	__dma_buf_list_del(file->private_data);
> +	__dma_buf_list_del(dmabuf);
> +	/* Must be observed by __get_file_rcu() before file_free() */
> +	smp_store_mb(dmabuf->file, NULL);

Resulting in NULL deref here -- guard with null check?

>  	return 0;
>  }

via this path

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..557cd7a4c971 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -725,6 +725,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 	if (!try_module_get(exp_info->owner))
 		return ERR_PTR(-ENOENT);
 
+	// succeeds
 	file = dma_buf_getfile(exp_info->size, exp_info->flags);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
@@ -739,6 +740,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 	dmabuf = kzalloc(alloc_size, GFP_KERNEL);
 	if (!dmabuf) {
 		ret = -ENOMEM;
+		// go here
 		goto err_file;
 	}
 
@@ -771,6 +773,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 	return dmabuf;
 
 err_file:
+	// ends up calling dma_buf_file_release()
 	fput(file);
 err_module:
 	module_put(exp_info->owner);
