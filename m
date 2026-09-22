Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F238C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 03:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 812F510E190;
	Tue, 22 Sep 2026 03:43:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGeCz65v";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TvdF9cZK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF30D10E190
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 03:43:17 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M00dX42824636
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 03:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PZx+XxSsWuqyEZeqeYrlTuUInOwB0nAJBJ9ykK9jmDI=; b=dGeCz65vQI/vthFz
 Z7gz743wVedhyA1MJftEpBzlLMHJTNk/Q7xYP64IVHso4wnA5N3ZX/ZWyyxjY/1c
 383YcK52FuUOCwWTGfmm5yRaabBaNUZs3RTWxyLrXQQzelgXLy1hMRV8k4uB0MSL
 sB2XqUtedXF41eUAYDMQPW/hQv27177PpJsOdzFPfHMnmyQwDbav1OnHUx1ZIvZT
 HeVgBDA1Pcq4Ji7bAtNBa4RFiRvA2ikuJWnNx4rqhf9gvUbGjRjIQ+pOhkjQKNYf
 ZiheZja5pfgRrcfMG1uqRhw1owBt2Zcp3eN3IQth2tWC8vzTDnEUKUDgDDoHktoh
 a4X+yw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu3cskkwd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 03:43:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dc0eee75dso995397a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 20:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790048597; x=1790653397;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PZx+XxSsWuqyEZeqeYrlTuUInOwB0nAJBJ9ykK9jmDI=;
 b=TvdF9cZKRlitUhB72H5OT2JSqV8wGxpsrgJ1k2dN2agOT6HR9Blkt3jl8RDPh3zm3W
 /gGlV/gzE7u9afO7UOvIGqqN+02L1RWDGxX5b2f1qIQl5SH3583YG3Y8Awrxh1kWQbOp
 /o+6HJVISMHbPnCQJHmbVTVJWeI4HLt5Sz/7gOBQ8YT2WmrEh8kK3ZipIfK76QZ1uJPB
 5CwMeqsq2oGuwg7+oB4vQjqDuSgsnfb1qZSmDUa7CQ/QqyrneIdPBJqyWaCsBUbtX4Dx
 rCQLlCYc3eeP1kMnN9v27qPoGvAwvkBdbgvYCJUM3TCzWpepqZQP6e8FHVJrita2/mXo
 qiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790048597; x=1790653397;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PZx+XxSsWuqyEZeqeYrlTuUInOwB0nAJBJ9ykK9jmDI=;
 b=AbyrJsgzRWFhfpTlRInMyL7dH1sgL5PIRDcyeJuyaaTxRUaONMJTMRETRnmbzCjt9d
 R+qkY+pp7u7Hfq4Z6VP4EQqo6qRS4pjwUWUdc9S3HxBZ5EwxUnE6Fp+QoqUpIqWvdfG9
 rupu8gOfcKnDn9gnSgjAjaNzDdpsSv/xqDuReX/EOJo+R99LogjlyRYb9o+tLhZLBTdt
 WTtKmqrFBIhBy0SaqqS2jWKpAC17/bg0Yfbri9Y6m1XvqZ+6O2tKBaoqNz9I23Gd9I5n
 /+LkzPD2PkcqfE/NX6rVW+Q1iqh6jmP1cFV4v+WZ7LqiokBSPEsrB8FYaNgYKCcxXdyD
 yWyw==
X-Gm-Message-State: AFuF++l0sD4QrTk6ZVr0Ve8dnVU6xv0WveOaBsTEe1wU1iMADwEv/2tA
 +rJsOamWxVht7h0sczkspjLojLWZmaOdyKG51Rw+VjgnDC3XW9VD1LFMNOZT7OvYKs6NR6IVn7Q
 zMHm/ThedruXYoswIwUsqPNdmgYfYZfciqQgQTdX0CskRJkEjPgEeGzN36JoUl+AIgtICeXg=
X-Gm-Gg: AYBFou0d/Q5adkVV69im9LLKmxNs8I71Qc8Rm1JbvvaBANzgOnMeGt3Vwm1YI9ad5Cf
 n8t/SCz/8ldRHFoJL1tUvg++iv4MoNGGmsx71UyH7q/5b4KqfcyBm5vaoVIuUT5e2dTH6M9lD1E
 m7aUI+LQ+rJ8rD36Su1my6jvU3AEu4svqQVU4FFx+k/UIGjWQyUKh+W51NfAcZnHXgPUI4bESKm
 tlTIZRDE/LcBzimL7o5pmCqHCnqTlhoeAKa4Ev8IY5IWu1B2QEk7KoMQm4nRZO9VYM/zFsDagfQ
 HLe+ORDcYE2QlU2OZpclEbyWhSR3viBCb1Rh8eoWUijcTU1P7BzgbZWRrO3nmEtBUeB0/28r3ZH
 IbP3oXVsPqNrHkkzpIyWZmav71HRcGyXGMuFCy8RejYfNiu6dD/SGSXHZuvVV84CqMm5QXIZUGI
 rfIhJG/dCS6duNcu9qP+ct
X-Received: by 2002:a17:90b:254a:b0:398:a2e4:c784 with SMTP id
 98e67ed59e1d1-39e5940c49cmr23208250a91.1.1790048596369; 
 Mon, 21 Sep 2026 20:43:16 -0700 (PDT)
X-Received: by 2002:a17:90b:254a:b0:398:a2e4:c784 with SMTP id
 98e67ed59e1d1-39e5940c49cmr23208225a91.1.1790048595821; 
 Mon, 21 Sep 2026 20:43:15 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f2a44cc8sm1165061c88.13.2026.09.21.20.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 20:43:15 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:13:11 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3] drm/bridge: lt9611uxc: support displays with up to 4
 EDID blocks
Message-ID: <arH5T6jJUC4T+hNL@hu-vishsain-blr.qualcomm.com>
References: <20260722-lt9611usc_edid34_misc_next-v3-1-7ec2bba6ff8e@oss.qualcomm.com>
 <20260722125338.383481F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722125338.383481F00A3A@smtp.kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA0OSBTYWx0ZWRfX648n1Bd+34Bh
 OnhHE8frfujhObZz41g7q5jcdIaOYsV0IMwQXR4PF86gZ/OCE8Z+/Wlfp//+FgmBSkIETGtJ5YD
 r32+3PGpEc8ejI+2791hgakwP1/sCNs=
X-Proofpoint-GUID: 2sAKE5ZDaUj42KiwTujMD5lWEZcrqLHi
X-Authority-Analysis: v=2.4 cv=QovLTlyd c=1 sm=1 tr=0 ts=6ab1f955 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=4oqKez96hxEG-nBsylsA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA0OSBTYWx0ZWRfXz6v/um1XWvar
 mymkOftnB3mjXnP3cxQkSY7BwBpEC9FtnsxGjCn7JGinzZJCoDkQS0F6wXY4nE2rPn25Ijx+AnJ
 7jVjvbeI0cfXSoXDV9efoOaCfKPvmBOU9gvGr/wg8u8VuGVAgm8KrXUs+T+lPnseNNVnSKFgFGI
 jVlvJkrPjBKPasdue4mLmACq/XxBBODCBbBg43/zk+GApaLxQJB2I1hhjlSgg35Zso1av9CrzUG
 JJz47HsOqpbQYOAZFBK1UyGcnmmJDlyFjqEP8+E7zegiJjyK6hgXKPIrExNXwvAp5puLoeo9wWV
 njc3bymdh06yOkasj7b+rnAF37V8Oi41MVsTtGk/B7r42zjShhEQVbl4TnYo0rZJ5XcLKhsdJjJ
 5a6RZTh+tKi2/wvJay+rSsC/WEpIj3LFIbuZhycGljstd3vfITRqg3Nru62IF8jO7r5pyXo8bhC
 R5/pMpeqsuD8Ui5/9KA==
X-Proofpoint-ORIG-GUID: 2sAKE5ZDaUj42KiwTujMD5lWEZcrqLHi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220049
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

On Wed, Jul 22, 2026 at 12:53:37PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Race condition in EDID polling loop causes torn reads for EDID block 2.
> - [Medium] Strict EDID header matching prevents DRM core from repairing slightly corrupted headers.
> --
> 
> --- Patch [1]: [PATCH v3] drm/bridge: lt9611uxc: support displays with up to 4 EDID blocks ---
> commit 63cb19491161c2c777e55262d8c46894374344b6
> Author: Ravi Agola <raviagol@qti.qualcomm.com>
> 
> drm/bridge: lt9611uxc: support displays with up to 4 EDID blocks
> 
> This commit extends the driver to support reading up to 4 EDID blocks by
> re-triggering the EDID access. It adds a retry mechanism that polls the data
> buffer and compares it against the standard EDID header to confirm success.
> 
> Link: https://lore.kernel.org/r/20260624-lt9611usc_edid34_misc_next-v2-1-24ce3f5770b8@oss.qualcomm.com
> 
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> > index 11aab07d88df6..20e3383a510a0 100644
> > --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> [ ... ]
> > @@ -395,20 +423,48 @@ static int lt9611uxc_get_edid_block(void *data, u8 *buf, unsigned int block, siz
> >  	if (block >= EDID_NUM_BLOCKS)
> >  		return -EINVAL;
> >  
> > -	lt9611uxc_lock(lt9611uxc);
> > +	if (block == 0 || block == 2) {
> >  
> > -	regmap_write(lt9611uxc->regmap, 0xb00b, 0x10);
> > +		lt9611uxc_lock(lt9611uxc);
> >  
> > -	regmap_write(lt9611uxc->regmap, 0xb00a, block * EDID_BLOCK_SIZE);
> > +		edid_ready_flag = (block == 0) ? BIT(0) : BIT(1);
> >  
> > -	ret = regmap_noinc_read(lt9611uxc->regmap, 0xb0b0, buf, len);
> > -	if (ret)
> > -		dev_err(lt9611uxc->dev, "edid read failed: %d\n", ret);
> > +		/*
> > +		 * Set the EDID ready flag so that lt9611uxc can fetch correct EDID block
> > +		 */
> > +		regmap_write(lt9611uxc->regmap, 0xb028, edid_ready_flag);
> >  
> > -	lt9611uxc_unlock(lt9611uxc);
> > +		lt9611uxc_unlock(lt9611uxc);
> >  
> > -	return 0;
> > -};
> > +		do {
> > +			msleep(100);
> > +			ret = lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
> > +			if (ret)
> > +				break;
> > +			/*
> > +			 * Compare first 8 bytes of EDID header for block 0 and block 2
> > +			 * to confirm EDID read successfully
> > +			 */
> > +			header_matched = (memcmp(edid_header, buf, 8) == 0);
> 
> [Severity: Medium]
> Does this strict EDID header matching prevent the DRM core from repairing
> slightly corrupted headers?
> 
> If the EDID read from the display has a slightly corrupted header (e.g., a
> flipped bit due to I2C noise), this memcmp forces the function to eventually
> return -ETIMEDOUT. 
> 
> This bypasses the DRM core's robust header repair logic
> (drm_edid_header_is_valid), causing displays that would have been repaired
> and worked properly to fail initialization completely.
> 
We rely on the header match purely to detect *which* block (0 vs 2) the
bridge has currently staged in the shared 0xb0b0 buffer, not to validate
EDID integrity - that job is left to drm_edid_read_custom()/the DRM core
once we hand it a block. A single flipped bit from I2C noise on an
otherwise-correct block-0 header is the same failure mode as a flipped
bit anywhere else in the 128 bytes, and would just as likely fail
drm_edid_header_is_valid()'s own repair heuristics or the block
checksum. We haven't seen this in testing, but agree it's a
theoretical corner case; not planning to change the matching logic for
this series since there's no cheaper signal available from the bridge
to distinguish the two blocks.

> > +			edid_valid = (block == 0 && header_matched) ||
> > +				     (block == 2 && !header_matched);
> > +			if (edid_valid)
> > +				break;
> 
> [Severity: High]
> Can this exit condition cause a torn read for EDID block 2?
> 
> When the MCU begins overwriting the buffer with block 2, the first byte
> written (e.g., the CEA extension tag) will immediately cause header_matched
> to evaluate to false.
> 
> Because the MCU does not write the 128-byte block atomically with respect to
> I2C register access, the polling loop will terminate prematurely. This returns
> a torn buffer containing a mix of new block 2 data and old block 0 data,
> leading to corrupted EDID parsing on displays with 3 or more EDID blocks.

This is the same class of concern raised on v2 (polling the buffer
directly races the MCU's writes) - there's no separate
transfer-complete status bit exposed to us, which is why the retry
loop exists in the first place. For block 2 specifically we're
checking that the header no longer matches the block-0 pattern, which
in the torn-read scenario you describe would only be true after the
MCU has actually started overwriting byte 0, i.e. the previous
(100ms) poll already saw a stable block-0 buffer. We haven't observed
checksum failures from this in testing on the panels we have. Happy to
look again if this turns out to matter in the field, but not planning
a change here for now.

I will rebase and submit the next revision 
> > +
> > +		} while (retry_cnt-- > 0);
> > +
> > +		if (!ret && !edid_valid)
> > +			ret = -ETIMEDOUT;
> > +	} else {
> > +		ret = lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
> > +
> > +		lt9611uxc_lock(lt9611uxc);
> > +		regmap_write(lt9611uxc->regmap, 0xb028, 0x00);
> > +		lt9611uxc_unlock(lt9611uxc);
> > +	}
> > +
> > +	return ret;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260722-lt9611usc_edid34_misc_next-v3-1-7ec2bba6ff8e@oss.qualcomm.com?part=1
