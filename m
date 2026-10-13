Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD7FCC6B14
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC3D10F5A4;
	Tue, 13 Oct 2026 07:53:17 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id E7AFC10E4D8;
 Tue, 13 Oct 2026 02:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:MIME-Version; bh=KI2btd297R1oHdc/tKxzf
 IhNKhPVfKEkKW+obUuhMWE=; b=MHYGTG6qxCv2Vclht/uFV9SgyPND+Xph7309S
 +uKkNUFMtdCFt3MjCmrB0iIWBBh1Bn4N8NPTniKOnsAkJzqLY0egabHi5pfyVUMk
 J+nfhGFaooN5yiO0Xllm8DXyduTikKPoxl5/K36nh4S7JxhzdWgxmaNps/DnN04f
 9kJg6A=
Received: from [127.0.1.1] (unknown [114.214.192.228])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgAnLTSkkc1qe3PdAQ--.14S2;
 Tue, 13 Oct 2026 10:04:20 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH] drm/msm/dpu: add the missing GC block to the SM8750 DSPP
 catalog
Date: Tue, 13 Oct 2026 10:04:20 +0800
Message-ID: <179185706019.408862.3377489837866634553@mail.ustc.edu.cn>
In-Reply-To: <20261013002124.332074-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261013002124.332074-1-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CM-TRANSID: 3pYKCgAnLTSkkc1qe3PdAQ--.14S2
X-Coremail-Antispam: 1UD129KBjvJXoWruw4kGr1kuF45Xw1DJrWrXwb_yoW8Jr4xpa
 y3Cr1Sqrs5Kr97Aws7uw17K3s7twn5X3srtFWrWr98Cas5KF1akrWfGFWUuryj9rZxG39r
 tFs8trZ5X3WUZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8KsUUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARETB2rNcIkC0AAasS
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

Hi,

Please drop this patch, it is a duplicate.  The same change is already in the
msm tree as

  3389406e6a03 ("drm/msm/dpu: Fix GAMMA LUT for sm8750 related DPUs")

applied on 2026-09-30 for v7.4.  I based my patch on v7.3-rc7, where the entry
is still missing, and I missed drm-msm-next while checking for existing work.
Sorry for the noise.

On sashiko's two findings:

- The missing gamma LUT size check is real, and pre-existing.  The DRM core
  passes max_size and expected_elem_size to drm_property_replace_blob_from_id()
  but no exact size, so a blob shorter than
  DPU_GAMMA_LUT_SIZE * sizeof(struct drm_color_lut) is accepted, and
  _dpu_crtc_get_gc_lut() then reads DPU_GAMMA_LUT_SIZE entries.  This affects
  every DPU platform that exposes the GC block (SDM845, SM8650, SM8750), not
  just the catalog entry in this patch.  I have just sent a patch that adds
  the size check to dpu_crtc_atomic_check().

- The GFP_KERNEL allocation in dpu_crtc_atomic_begin() (through
  _dpu_crtc_setup_cp_blocks()) is also pre-existing and independent of this
  patch.  I did not want to bundle it with the size fix; happy to follow up
  with a separate patch if that is wanted.

Thanks,
Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>

