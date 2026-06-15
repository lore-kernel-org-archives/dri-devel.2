Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D59ACD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 22:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46DAB10E53B;
	Mon, 15 Jun 2026 22:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="coj3dEIM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZWQ/hDfh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D33DF10E539
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 22:42:16 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxExK882163
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 22:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zHE3dR2u6AwWN2e/vCgwqj+r
 w4dt77oofxvwtyZmHYk=; b=coj3dEIMglK8jz1O9wLV3JJ0V9KohF9ZN1N74BiJ
 ysauhdGXYwQ8SUaQ8TNhE3gdj0edIvUbk/naMKCS4/ZQk8Lx+iZ+Ck4Tuy3qgk5H
 A5kK2rPaZQIr4gVKBuNr0jymfDWrVwtk5m9ct1OUTppkzeAbRwwAt+dKiHfHTbOn
 9FUf1KdbzRyg+t0uL7nLM3OvN4bA+niLjcO3eI7n5ZyLlmzsLiEibPX9NujF4a5T
 QZrLTHbhPXyWPK+CBL/LZmoAzXvt2sHwdl2CuYi7JqW6ZLU+sbtRPfS56r9a2mpv
 FX1pU4Kc30myhfCh9/E0TuqYDZd8QmZffAgdffvu8kNLhg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0kdrp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 22:42:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-517ac42d958so74455211cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781563335; x=1782168135;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zHE3dR2u6AwWN2e/vCgwqj+rw4dt77oofxvwtyZmHYk=;
 b=ZWQ/hDfhD6ulFbFSOSlGpryTsZsRnwvB8SmkUhgPofxgJarpFjaLwvQrAwiSBcvbAf
 QCXtepzkXC41lYuvUvGVyl8CxsnqGSKeJl2QJHESjA0SbWW07qtbzqNVYOx6fjKSJ5Zu
 14MlYYn5KxnJxeVDi/Nn/biB/z5R5/75OsAlxrnER7RXrAZYq6csOrbrdC1/EuvTr+ik
 hU8Z2wtjM2tAxL3BLv/5O8whQmcQw4LcaZ8v1KOZJAtRZt8x65WhItKY2GlAhf/CHiR+
 dWS3QKOX50w+J4m24j5le91VacEdaw1MombI7E4X/VgxumvjID0RU2XJzJPbZuk9Wlai
 wgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781563335; x=1782168135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHE3dR2u6AwWN2e/vCgwqj+rw4dt77oofxvwtyZmHYk=;
 b=CfaRASs8LC6Do1uQbxRB5R94lSsWYr/em/9QlCaf3YXxdY7Al1KMc60ykF0SIiafae
 2g1yk3HB5eNAc7VmVAmLbyU7dacOCNqHvUmEenhcoJS7RoR0pOWJl7hTChGNUgzqjI0s
 MkegJ5pCjYDJSIMkJlADmFnUEL0dq//f0cfcrX/0nDBQOCKBr8O5EuGUfzZIC/3g/GsJ
 vJ1FE4iFKZmRqzliB/xzF74E7wl6a6sjOriT2zTsrjOW0Q5I+8IMGukz7WdIKJCbsI25
 QngD8j/ZOuRRAgFopQAnby8WFNtjEs44W2UM2URRK485SoCEHFbV44S24bWzbptXKqwJ
 Ebuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TeNCUdQeyFLXYTlcwbk/CeWeh1ab2U+ExjlaOWcKKNv4BisLg/QcGCgzWYaZqw1oqG4uqU0eZuiU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycIXEl+Xmi0FCFqQKg/FrLSTnG657UWfWWTZx5HewMbG1PbeXk
 WVauSxg9taAg9ddrg2j7As2hIznKaxznr+I1dA4lZlQuqDH00vuVcJA1PFlP8KQdKnKmWYntFHM
 uhPAI4cLlEVtnJr3cAqoWcxb2iB0d1olW3FvYPCeFLai82ahkICiULItKtfy14Wlkj6drO7A=
X-Gm-Gg: Acq92OE35fH9uTaxJo8R1wHzA+hpBnCPLT38C+soL77WrynvxCqMdnKgnQvgxCXnJX9
 ZiO3rz2cqFChDeMPXXmfwyVjtx1j2HwMVJbfco8eiZ3Nzbs8nrkvrjY1rIYbICA19JSRNo5MH8k
 x5B1uWjIp2Sx7AiWkxiF5FgvkxmC8+g33Wo6XNBR3edKlI22DvjndQ81In9oktNLIbF2LGQxc15
 /cvVg8d4pTxmbXTj/pH5rYs3LzgZaK2l5oCL7iw1LCSn0AMt4t3DzPvsN8K9Lod7Hp8gfdSUe6w
 cthtLlc5xSudLfpnpx7U7B8AnILfSgBdD7x90TZPo9BJjoLRPY3GUyIXxKQExuzdg8z+R0s66Hx
 GeYZWdm8q+0KO9SVedPNjDgZ2N0gK66wSiElNchsn1NMF0WzcWlizUsOFBSuTo/+aA0i2RmZ/ot
 eD8tv1GMQyQwGacUXAFZX/F3XpOrHkA+M2aLg=
X-Received: by 2002:a05:620a:2945:b0:915:d322:c47b with SMTP id
 af79cd13be357-9161bc4b5ccmr2472984985a.13.1781563335134; 
 Mon, 15 Jun 2026 15:42:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2945:b0:915:d322:c47b with SMTP id
 af79cd13be357-9161bc4b5ccmr2472980585a.13.1781563334472; 
 Mon, 15 Jun 2026 15:42:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3995c059bb8sm2169691fa.10.2026.06.15.15.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 15:42:12 -0700 (PDT)
Date: Tue, 16 Jun 2026 01:42:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: John Harrison <John.Harrison@igalia.com>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org,
 wsa+renesas@sang-engineering.com
Subject: Re: [PATCH v6 3/9] drm/amd/display: use
 drmm_writeback_connector_init()
Message-ID: <eieq74qmqkkrgovktpon6umq2an3l6xmih2gqxjqtawmtvnesl@zpxepcxb3hm6>
References: <20260612-wb-drop-encoder-v6-3-9f3a54f81310@oss.qualcomm.com>
 <20260612185828.C0D241F00A3E@smtp.kernel.org>
 <e98e6632-20a1-4e76-a6e5-916066c7438a@Igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e98e6632-20a1-4e76-a6e5-916066c7438a@Igalia.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDI0MCBTYWx0ZWRfX058v1U7oRRYA
 AIXJOMLHzzJTNI4TfuKXjFHvsjzulISEwkL0tG7a8zn0A3l9pF1lCQgK8CTX6UFpJ4OjLOIR/H/
 /ava85uUSoix6WqwBmprLxf84o9jGdQ=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a307fc8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=MhOIpkx3JouqtUk9ItIA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDI0MCBTYWx0ZWRfX8Sil7yY6LagR
 hodAcdMKiMrY2BT+dc7nlB7Gq2WJgpqTbW0cGOF+Dac2Pd+JQPmjfnfTgXa0dM+d+pXqqfj9zus
 oPs4r6jFSkAH6GTp90Fcu5UJta6BVD8lh+Fi/YJ+jn5azCv9oKqFzUk8itBTbLR3aEaWTUl6qpW
 HCHZPXB6mE0br81KRAcMLPFFZ9WIhgtqN/9o+Kwnopy4R9ozJEISDz6ImbO/gs+LA8Y00rjT/6G
 3cxHAm6Kp9eucpjTl2En8D9nV60ZW5G4/yqUe2fX+a2eZBcl7z8M1rjsiXVv9AbbxLIJwAjAU2P
 6/6cXODBiCi0UOAn/jIX/f9LXUZzUuumCPdnrieSr/PTRPX/7a9DYl7adcS2ofhw+jsEX3Dhe/C
 2YrcXDe6D8FJGoWW1iqFBSraXoYeiUtnWALByJao03x1Wpz804duP2uUccVlHA9MZfRsdJZtctF
 5Zxmw4BKx9NMLJirHHw==
X-Proofpoint-GUID: Ilxt1A330yXLBkgi2mHDqtUnZG3uMGK3
X-Proofpoint-ORIG-GUID: Ilxt1A330yXLBkgi2mHDqtUnZG3uMGK3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150240
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

On Mon, Jun 15, 2026 at 11:27:12AM -0700, John Harrison wrote:
> On 6/12/26 11:58, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > 
> > New issues:
> > - [High] Dangling drmm cleanup action on writeback connector initialization error path leads to Use-After-Free, and possible build failure with drmm_kfree.
> > 
> > Pre-existing issues:
> > - [High] Pre-existing memory leak of `wb_info` and sleeping in atomic context in `dm_set_writeback()`.
> > --
> > 
> > commit 946e1af8401710237d25526b5d87b4357eceb542
> > Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > 
> > drm/amd/display: use drmm_writeback_connector_init()
> > 
> > The patch converts the driver to use drmm_writeback_connector_init() and
> > drmm_plain_encoder_alloc() to ensure proper cleanup of the writeback
> > connector instance and its job queue.
> > 
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > [ ... ]
> > > @@ -11086,7 +11086,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
> > >   		return;
> > >   	}
> > > -	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
> > > +	acrtc = to_amdgpu_crtc(crtc_state->base.crtc);
> > [Severity: High]
> > This is a pre-existing issue, but does dm_set_writeback() allocate memory
> > using GFP_KERNEL in an atomic context?
> > 
> > It appears that wb_info is allocated using kzalloc_obj() earlier in this
> > function, which implicitly uses GFP_KERNEL. However, this function is called
> > from amdgpu_dm_atomic_commit_tail(), which is an atomic context where sleeping
> > functions are forbidden.
> > 
> > Additionally, dc_stream_add_writeback() copies the contents of wb_info by
> > value, but the originally allocated pointer seems to never be freed before
> > dm_set_writeback() returns. Does this introduce a memory leak every time a
> > writeback job is queued?
> > 
> > >   	if (!acrtc) {
> > >   		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
> > >   		kfree(wb_info);
> > [ ... ]
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> > [ ... ]
> > > @@ -188,17 +187,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
> > >   	struct dc *dc = dm->dc;
> > >   	struct dc_link *link = dc_get_link_at_index(dc, link_index);
> > >   	int res = 0;
> > > +	struct drm_encoder *encoder;
> > > +
> > > +	encoder = drmm_plain_encoder_alloc(&dm->adev->ddev, NULL,
> > > +					   DRM_MODE_ENCODER_VIRTUAL, NULL);
> > > +	if (IS_ERR(encoder))
> > > +		return PTR_ERR(encoder);
> > > +
> > > +	drm_encoder_helper_add(encoder, &amdgpu_dm_wb_encoder_helper_funcs);
> > > +
> > > +	encoder->possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(dm->adev);
> > >   	wbcon->link = link;
> > >   	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
> > > -	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
> > > +	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
> > >   					    &amdgpu_dm_wb_connector_funcs,
> > > -					    &amdgpu_dm_wb_encoder_helper_funcs,
> > > +					    encoder,
> > >   					    amdgpu_dm_wb_formats,
> > > -					    ARRAY_SIZE(amdgpu_dm_wb_formats),
> > > -					    amdgpu_dm_get_encoder_crtc_mask(dm->adev));
> > > +					    ARRAY_SIZE(amdgpu_dm_wb_formats));
> > [Severity: High]
> > If drmm_writeback_connector_init() fails internally after successfully calling
> > drmm_connector_init(), will it leave the drmm_connector_cleanup_action
> > registered?
> I'm not following this one. everything that drmm_writeback_connector_init()
> does has a check on the return code and only if everything works does it
> register the cleanup function as the last action. So how do you get a
> dangling anything?
> 
> > 
> > The caller, amdgpu_dm_initialize_drm_device(), appears to handle this failure
> > by attempting to free the connector using drmm_kfree(). Since drmm_kfree()
> > requires a dev argument, will this missing argument result in a build failure?
> Bizarre that it is complaining about something in a totally different patch.
> 
> > 
> > More importantly, since drmm_kfree() frees the memory but does not unregister
> > actions, will the managed resource list later execute
> > drmm_connector_cleanup_action on the already-freed pointer, resulting in a
> > use-after-free when the DRM device is torn down?
> Isn't this just lying? The whole point of drmm_kfree() is surely that it
> does unregister the cleanup of the allocation?

The question is not about freeint the memory, but about unrolling the
connector registration. I'll take a look later whether Sashiko is
hallucinating or not

> 
> > 
> > >   	if (res)
> > >   		return res;
> 

-- 
With best wishes
Dmitry
