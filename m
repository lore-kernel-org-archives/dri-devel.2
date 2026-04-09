Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E270F31E22
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C81810E83D;
	Thu,  9 Apr 2026 14:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QWUv/xiM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZxcRp00n";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A9F710E83D
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:52:59 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639CxmEq1729939
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 14:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lTKXEEfEkbo8patR5RlRtyxf+q7DRuscaUKI+vzwDWI=; b=QWUv/xiM+RZtsrJG
 M4Tv9WJ/UWFf/IWgVRyy+L0/tndEjdVdlKeS554KPptMdnU8ac2Qpv5MxQWXwfCr
 GXVrz5UVT+FXPJRnziRJxhKF/T2QpE6PLdH68AuebcuChkKTYZvmRDhml4OOMfKp
 s67SBWgA5dsc2VVAFd1TNDGbmfz+RkXYZI4BOex7J95O5DBQ/5VxpDkcMjWMpmLL
 Ow9mcUa1qkKDapLEHLZt3vrvdsYFwgbe7MVoOiQ8AQjwAEAPwFVcTuCgCfclOs3q
 JdhJkQF/PhpFXzMykmfNvyq19jM0tpAG3Lu0BO3ajfJFRSwf71DDzqoOr4b3vbPJ
 cO44vw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckxgecw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:52:58 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6054b4d721fso1375925137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775746377; x=1776351177;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lTKXEEfEkbo8patR5RlRtyxf+q7DRuscaUKI+vzwDWI=;
 b=ZxcRp00nVF/7PgUQd8ajNYAtshu33CewRLNBQz7lc9jwp//I3na+jzzZE/TuQDD/mH
 egW08HncYE93tblxhc6uvxXGdn3E+30xQHE/hW46Lk/BWzh3WSSLxZNOkodjOFqcWxt6
 cGaVco1cNfuESBkYonO8zDNe5qZpWvKCcUAWT3KwofFvp7TXlSq3aOHKoRQ3FVwaB2JN
 1fuh/c8mIz2k0LxUDwIg7qheWTbCISycmrKQ/niRiKq0RIbvjmBmT/mL9Ukw3pU9oS+z
 RB4TUMx3im2BiaE1Rk74TIorL/MTr2GNZPQ0idakpok3hjdHQn2sc8dRG1Otd39mSRIB
 0AdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775746377; x=1776351177;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lTKXEEfEkbo8patR5RlRtyxf+q7DRuscaUKI+vzwDWI=;
 b=oYDQgP4CLHJTNLEF5opx0M3Y67yYJEMTImttZ8y+Hmyou6vTqJ1Z+7h8ex7VqgQVWT
 aqRUjvVLjS5M2HfSH71S6Lap/MtQZagLYl+0nFvCZILJ50eGk0SBvzn5yrXqUB/0pC9N
 OHUwYa7iTSwp0+dPG68S42BFAghadeUhiuu/CK0h3DEBtMP5rz3ipSJDWAprK8pUArNK
 pILQMckHles4mqufqtoCW1N6yONzatMxpTgXkGvV6exRpZwI171BMCCA6LGNOvkh75Ru
 7TKiEFubq+PghvOw/E3rgmmxTyI8hdp0L+IDr4jQPtURxj9eP6VLr62C3WspjpEqc4bJ
 +osg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjAy+O1vaae++he2lhSiPsbbAwUfsUAm8OJ0F0hT1AfEOzTsMySaJqodNeNhz9g/HwFV+TuCTrUlQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDgVtYRgp5+qxqSx5VX+a2MAu3ex5rKtBGE4JFhoTFBNcvrTgc
 0YkLj9QJYgrXcBVlnIRdEbBzjYXj1OmcWt32cZJvPuc7Qaj7LLGGOgJjEgpvWSsRR3kBpm1YJWz
 pwJGJsUxF+FIC8u/Uhq+reo7/fiqH1zxQk7HEPjl30aht2YLWjTyO0sScjKoRKk9+A1b/BNBVXq
 YtJVI=
X-Gm-Gg: AeBDieuYAP3au7j/qD6im8m2r2OAXv8aguI+mbCgsSwShB1sZkLlq5UBPUQz8o2iAWk
 osj5qTHCuDL5X+fm7gIHcotyd3SzVC6rygVMV7rRC4PpsQcRpkAQ1JHHALCU36906dwQQcUeVH3
 SD1uWcLiDe5YcvqNPvDmrC1ElNL+qw0ykt35mhSXquRA4pJWiN6xgMaI7WPCf7cgoQGhoT98Pb6
 6fZmSCfUu1QtgS2Iw+bC5VECkV3BwfVnQREitkO+fh5DgzD7XJEUNFQfsOl18WDptfQ7i6k6VID
 pduGAV3QzDMURPQ+I62DZ8WUeiZZbh5q+UABsW1oMZvPkJPtBUMRo1JhNiq97QwkbMIoTYX0ScX
 PgHu+KaurtfyjXVG9/pCSqnfWmhxtaprTF4zjfUhMPmPYWBfuPFubbNoaPoUj2EhSC6nnbP06gV
 jDvZ2QnDzXUEI7EdHnvee9XXfxWedUfdAqbbY=
X-Received: by 2002:a05:6102:943:b0:605:673d:18c4 with SMTP id
 ada2fe7eead31-605a4e11f7fmr9946563137.9.1775746377508; 
 Thu, 09 Apr 2026 07:52:57 -0700 (PDT)
X-Received: by 2002:a05:6102:943:b0:605:673d:18c4 with SMTP id
 ada2fe7eead31-605a4e11f7fmr9946553137.9.1775746377019; 
 Thu, 09 Apr 2026 07:52:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e49298c4dsm9121fa.13.2026.04.09.07.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 07:52:55 -0700 (PDT)
Date: Thu, 9 Apr 2026 17:52:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 36/38] drm/msm/dpu: use msm_dp_get_mst_intf_id() to
 get the intf id
Message-ID: <zosdnfcnqqhvbqhe236csccf4i6sgh6ocadmr5v5xvylkpk3nu@huphblztbdm5>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-36-01faacfcdedd@oss.qualcomm.com>
 <exfflgjky4zgqa7tnudfteeosncr6nsuwqadxnfftxtjay6hke@fxru2weupuwt>
 <10464c59-31cf-44e5-9d7d-68b04ec2529c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10464c59-31cf-44e5-9d7d-68b04ec2529c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: bPCWzogpJy5kH9iKRTilrXzXZCrOpx2r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEzNiBTYWx0ZWRfX1TEUalemAfKs
 rMQC5GGi8sH4AaoZeMTmyR82JuuijRCT0wt2SmFupHM+tLEkbFuhsAv65pzNlkO3ouwU9cPo/yj
 SWJXHCVQEFsPg9bXqh+qU4PTRG246jnAiXXOG5uoLl+KmOfnuMlKsOhiKfzVZcvKLsTpp+pFDRH
 VaalTKUeAu7CyJOTpbHmTV1P+tMk3nZFCRXhJA/Ek+gMQUYOdpk4/P0QFAmSmzPCNumlfq6FQOo
 56sQoe6zNkHA7DqWaxJ/67gWCWN26IP8IhGtQUmcN0chqFXFZHFr1G5ZjkjHh2GPzkZK301cjCd
 C5j97e+G8idi21cj7BUhJSbmsEcx1L2xC580o4Cs2fHiXknPa6DDHkpnnvZMB6Jw4zOFu2gB+8M
 5FtEaqTRY3z/P4b+m3VjzgwrND8fmP9ls3wH4nCv2dNtgn8LZeEK7EHjyw5ukG6ICFZmc5+ucW/
 timdUD7h/UEkrCJIO0A==
X-Authority-Analysis: v=2.4 cv=OMcXGyaB c=1 sm=1 tr=0 ts=69d7bd4a cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=tXddtnhPeo1MaeQpTl0A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: bPCWzogpJy5kH9iKRTilrXzXZCrOpx2r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090136
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

On Tue, Apr 07, 2026 at 10:32:22AM +0800, Yongxing Mou wrote:
> 
> 
> On 8/27/2025 7:42 AM, Dmitry Baryshkov wrote:
> > On Mon, Aug 25, 2025 at 10:16:22PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Use msm_dp_get_mst_intf_id() to get the interface ID for the DP MST
> > > controller as the intf_id is unique for each MST stream of each
> > > DP controller.
> > 
> > I think we have one sensible exception: SC8180X, where we have several
> > DP controllers and one shared DP interface, but let's forget about it
> > for now...
> > 
> Sure.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 51 +++++++++++++++++++++++++----
> > >   1 file changed, 44 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > index 05e5f3463e30c9a6bd5b740580720ae2bf6b3246..2eb5397d15732b224372c68d0b2b7167da9f2896 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > @@ -1429,17 +1429,52 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
> > >   static struct dpu_hw_intf *dpu_encoder_get_intf(const struct dpu_mdss_cfg *catalog,
> > >   		struct dpu_rm *dpu_rm,
> > > -		enum dpu_intf_type type, u32 controller_id)
> > > +		enum dpu_intf_type type, int enc_type, u32 id)
> > >   {
> > > -	int i = 0;
> > > +	int i = 0, cnt = 0;
> > > +	int controller_id = id >> 16;
> > > +	int stream_id = id & 0x0F;
> > >   	if (type == INTF_WB)
> > >   		return NULL;
> > > -	for (i = 0; i < catalog->intf_count; i++) {
> > > -		if (catalog->intf[i].type == type
> > > -		    && catalog->intf[i].controller_id == controller_id) {
> > > -			return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
> > > +	if (enc_type == DRM_MODE_ENCODER_DPMST) {
> > > +		/* The intf order in dpu_intf_cfg matches the mapping in the DP HPG.
> > > +		 * example:
> > > +		 * DPU_8_4_0 - DP Controller intf to stream Mapping
> > > +		 *
> > > +		 * +-------------+----------+----------+----------+----------+
> > > +		 * | stream_id   |    0     |    1     |    2     |    3     |
> > > +		 * +-------------+----------+----------+----------+----------+
> > > +		 * | DP0         | INTF_0   | INTF_3   | INTF_6   | INTF_7   |
> > > +		 * | DP1         | INTF_4   | INTF_8   |          |          |
> > > +		 * +-------------+----------+----------+----------+----------+
> > > +		 *
> > > +		 * DPU_9_2_0 - DP Controller intf to stream Mapping
> > > +		 *
> > > +		 * +-------------+----------+----------+
> > > +		 * | Controller  |    0     |    1     |
> > > +		 * +-------------+----------+----------+
> > > +		 * | DP0         | INTF_0   | INTF_3   |
> > > +		 * | DP1         | INTF_4   | INTF_8   |
> > > +		 * | DP2         | INTF_6   | INTF_7   |
> > > +		 * +-------------+----------+----------+
> > > +		 */

Drop the comment, please.

> > > +		DPU_DEBUG("controller_id %d for stream_id = %d\n", controller_id, stream_id);
> > > +		for (i = 0; i < catalog->intf_count; i++) {
> > > +			if (catalog->intf[i].type == INTF_DP
> > > +			&& controller_id == catalog->intf[i].controller_id) {
> > 
> > && should be on the previous line
> > 
> > > +				if (cnt == stream_id)
> > 
> > if (cnt++ == stream_id) return;
> > 
> > > +					return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
> > > +				cnt++;
> > > +			}
> > > +		}
> > 
> > return NULL, drop else{}
> > 
> Hi,Got it.. Does this code looks fine?
> ......
> 	for (i = 0; i < catalog->intf_count; i++) {
> 		if (catalog->intf[i].type == disp_info->intf_type &&
> 		    controller_id == catalog->intf[i].controller_id)
> 			if (cnt++ == stream_id)
> 				return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
> 	}

LGTM.

> ...
> > > +	} else {
> > > +		for (i = 0; i < catalog->intf_count; i++) {
> > > +			if (catalog->intf[i].type == type
> > > +			&& catalog->intf[i].controller_id == controller_id) {
> > > +				return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
> > > +			}
> > >   		}
> > >   	}

-- 
With best wishes
Dmitry
