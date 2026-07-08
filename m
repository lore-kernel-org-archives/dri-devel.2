Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8271FC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1FEE10E24A;
	Wed,  8 Jul 2026 15:29:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MJxcrN1J";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eaWr7KNg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7299610F184
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 15:29:36 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668Er9Eg3101286
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 15:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 70zYiNfQoqGUZwaTbkI3q8uUAT8YrVOohiWmsnW1WKY=; b=MJxcrN1JXBcMtK19
 Pfev8qimb74w+MKw5k/hUYNzgU+zE4Mw0fSpCrFZ7lOHvxSs7oJm7ErpsBWzwnpI
 un/NMMOnDxsNcpt35kidw/cp/zKCBzjBPf5Jt4Mg8aW5zQgbqsPs64EiB9yHTduO
 hOs/FTUhYu8rcejTKUgvikj1tz5ROiKrcsqFKbvtzLjwOzLrBSUFjar/QB5/mBxC
 Vdmmmh+jeVwJkXXyWVzBj6xnOpcug6wFu1X5gsWcMTLci35ybLIj71oZisxgrzwt
 vWPl0BbEThkIZX4pYpJ2aB1KhJwDUSwlzFmsg10/omwf9phFFsq/4ToVgHjd+VlX
 yF+Lqw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9rq305mf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 15:29:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-381d039b797so840777a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 08:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783524574; x=1784129374;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=70zYiNfQoqGUZwaTbkI3q8uUAT8YrVOohiWmsnW1WKY=;
 b=eaWr7KNgXawHW6hQRjFDfBfJRvo6HtvYz5oPNfb06J1kGjQHt/UB8sJsJaw+M22CKG
 MJ2OMTsHDtYmhXiimvRB+uLmrcghYJYVbrhVlukuBPDLR6qEt3pbCKPv4uhGRDnsKyz7
 nXZDqUEizuahN8KCy5igxG0UXIwA+qgu8BJrmXjy/xo06Pj+6Nv8QkmDeB82Z0yTmgR8
 0cEwEBY8bGimxj/Vfy08Z4Jc+5WTc/u/f5ClLyVDvxp8YDNJRbjZaKkDER9/DFMAYVCe
 MzTnFCaYnecLfL5qKwFwD4GXMRlpCRksJJLgKF8xEcpbvXyFqMptXonhfeQ3o6torwLl
 v1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524574; x=1784129374;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=70zYiNfQoqGUZwaTbkI3q8uUAT8YrVOohiWmsnW1WKY=;
 b=APz9QAjXaUyllxnndUS0LTAmQixYP1b7/JjEWk9J5Q60oz5LZ7cSjDEsLnJgNsNwaa
 3x0yyLMqMFO2IYhaAMlkQzx7MljJnb/QEvwsJWZzY13aO6r5NZ5bBKG9b0fvZITA2gs2
 8mVCr1v2wRlzmXcf4QvIRN5reUw5kEwiKdRtY90h3oSt0lpW9rwO3INpZWC6NJKfyTI+
 6vFvQhuhSrcdujOn+LEg/CFgg4pxfhju3ZXxo9WuOqXgNGb/ze4nNGDNFqt0KF1A5cqJ
 znf1AtKT0gwMsEronfgyq1OdCkPzs61H82m52Je5jX7c9cEKj08oSYa00zW0afhndG4o
 Ar9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrgpk0/s4iheXDTZ+eUgDi/9P10QcbMAowkS+pvZ5veEbMcXdmJ+YBPHy7Fs5mrxpj9nUevUvCTBNw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yytmc5UfsYhOM0DODpO4mpfyVa3ryR5kgBg2dlYbI3OMubL4TGX
 iAWDzKGEv7q6yll9P5kAQxgoZF0RZ9zKjxIIINlU/yq+PJxC6E9Dbe0m8QdOI4A3Lf3Dfh3VPEu
 5XXqpEtMiNeRiXTuQAtdMG3GYxQiUdelx8H/7320Kw7kIGXByoak+GkGT5TMsqXWGWGC5KpE=
X-Gm-Gg: AfdE7ckqWFMbbQtxtjs4BJe1PhnDu8lU8gNEHjTh77/Oi0LmZs3g2Yb4ONu8eL8RRaE
 ty8BkrwJ6cpzm1T/fpUe7/z5Am2u9hsLfmX5hc/RbHymS7IvuTDk0Bg5mnVpioxiUTMN5h80SiD
 NI/YB5e6Tl8MOBuXsJgCnfPEy4SRZevtmvcnlzTNSA2hcRU0x0Jfve28ByfWVl+Igz8fewqe1h/
 TSihf341k8DagtVHncDXz+7G/S6SK9+fzJHKH0hxvoz5UcITp85v3jjuSoLk8HX5KT9zMhWcb3T
 WX7i7nHPI28RnOdBLIdBcHj0Hz4rhgamc/dGAb4PsvnCnEXi/nveWPuB9HLb+Om4ugsSltzFtw1
 fzfNYjuPjGZ9zLe4=
X-Received: by 2002:a17:90b:1f83:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-3893fe5c05dmr3200407a91.6.1783524574186; 
 Wed, 08 Jul 2026 08:29:34 -0700 (PDT)
X-Received: by 2002:a17:90b:1f83:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-3893fe5c05dmr3200358a91.6.1783524573598; 
 Wed, 08 Jul 2026 08:29:33 -0700 (PDT)
Received: from localhost ([151.243.38.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-387d3c675b1sm2862308a91.15.2026.07.08.08.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 08:29:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 23:29:18 +0800
Message-Id: <DJTAOV6K82ZR.3T4EZDN7HVQ28@oss.qualcomm.com>
Cc: <imx@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <Frank.Li@kernel.org>
Subject: Re: [PATCH 9/9] drm/xen: replace struct drm_simple_display_pipe
 with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: <sashiko-reviews@lists.linux.dev>, "Ze Huang" <ze.huang@oss.qualcomm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-9-b4e1ca053623@oss.qualcomm.com>
 <20260704185346.627B61F000E9@smtp.kernel.org>
In-Reply-To: <20260704185346.627B61F000E9@smtp.kernel.org>
X-Proofpoint-ORIG-GUID: 0SDcmaowvRPgDQzy-RI3650sbCp6534U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1MiBTYWx0ZWRfX2DN+RnAtV2dx
 Jm/o/B1zKZvfWiISXSuUaxOPsdWdsOuL33cmVHD4Bi7SMc/rQUv9G6+DyU8t5kYEHoq94UavAb6
 7lfDK0Ezw+Y71lXufS/UX7X59xKUsWj85jpqVlgaqpqF0SB7ePMCFB5uPjVTxGXzPqDUwmbOrZH
 HtMbjHrUSz0QnRhEe5aBG5Fq1p18V3it4bZ++8OvbWFr1IvV/uBOgggfxjE2EQldFK0UuLLtnmY
 +j5WRBCy624VNHGWdKG1W5Z/S/XLBDILcGqIo51BqrWYzt+gUlXE0uE5n+g6PyM5xBhT9hDCNsj
 csTP5N1rfTYl+VQ1Q0dmQvMQby9TjaKGvQ3L+ESP/fYVdMuFwHp6YzDlI7Q6U35/ef9n+EWL3Yl
 IPL2Rdm0dpDo6gDltdXxOevRagRqTpe0yLDHkppTlWZush+KIfYm7fQdJj87xiWxgdR0cbVsUtr
 8fFYiSHVGfmcsgR/E8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1MiBTYWx0ZWRfXyv+oMEp+UGJE
 QpmFsN/Yt27ofrCcQXr8Bpct8LnzEGS+xxjERiEhPALbSZh/H1uYEvxudHMOCiUC8bkmRCfHILf
 MK20bHDEJH5fifirLfrgyh1/gQS2V2g=
X-Authority-Analysis: v=2.4 cv=PYPPQChd c=1 sm=1 tr=0 ts=6a4e6cdf cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cXiuqu8dGSoeSI90gQIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 0SDcmaowvRPgDQzy-RI3650sbCp6534U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080152
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

On Sun Jul 5, 2026 at 2:53 AM CST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Hardcoded `possible_crtcs` mask restricts all primary planes to =
CRTC 0, breaking multi-display support.
> - [High] Direct access of global `plane->state` and `crtc->state` in atom=
ic commit hooks leads to race conditions and stalled events.
> --
>
> commit 8a32b307abb3d8e006d032d01a1802aa1e4ae6f0
> Author: Ze Huang <ze.huang@oss.qualcomm.com>
>
> drm/xen: replace struct drm_simple_display_pipe with regular atomic helpe=
rs
>
> Replace Xen frontend simple display pipe with explicit plane, CRTC and
> encoder objects for each pipeline. Keep generic plane-state validation
> before Xen-specific checks, and install GEM framebuffer prepare helper
> explicitly.
>
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/x=
en/xen_drm_front_kms.c
>> index 48772b5fe71cf..57e1bef452f83 100644
>> --- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
>> +++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
>
> [ ... ]
>
>> @@ -105,17 +105,15 @@ static void send_pending_event(struct xen_drm_fron=
t_drm_pipeline *pipeline)
>>  	spin_unlock_irqrestore(&dev->event_lock, flags);
>>  }
>> =20
>> -static void display_enable(struct drm_simple_display_pipe *pipe,
>> -			   struct drm_crtc_state *crtc_state,
>> -			   struct drm_plane_state *plane_state)
>> +static void xen_drm_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>> +					      struct drm_atomic_commit *state)
>>  {
>> -	struct xen_drm_front_drm_pipeline *pipeline =3D
>> -			to_xen_drm_pipeline(pipe);
>> -	struct drm_crtc *crtc =3D &pipe->crtc;
>> +	struct xen_drm_front_drm_pipeline *pipeline =3D to_xen_drm_pipeline(cr=
tc);
>> +	struct drm_plane_state *plane_state =3D pipeline->plane.state;
>
> [Severity: High]
> Is it safe to access the global pipeline->plane.state directly here? If
> non-blocking commits overlap, this pointer might point to a newer,
> uncommitted state. Should this code use drm_atomic_get_new_plane_state()
> to extract the state from the drm_atomic_commit object instead?
>
>>  	struct drm_framebuffer *fb =3D plane_state->fb;
>>  	int ret, idx;
>
> [ ... ]
>
>> @@ -242,15 +259,19 @@ static int display_check(struct drm_simple_display=
_pipe *pipe,
>>  	return 0;
>>  }
>> =20
>> -static void display_update(struct drm_simple_display_pipe *pipe,
>> -			   struct drm_plane_state *old_plane_state)
>> +static void xen_drm_plane_helper_atomic_update(struct drm_plane *plane,
>> +					       struct drm_atomic_commit *state)
>>  {
>> -	struct xen_drm_front_drm_pipeline *pipeline =3D
>> -			to_xen_drm_pipeline(pipe);
>> -	struct drm_crtc *crtc =3D &pipe->crtc;
>> +	struct drm_plane_state *old_plane_state =3D drm_atomic_get_old_plane_s=
tate(state, plane);
>> +	struct drm_crtc *crtc =3D plane->state->crtc ?: old_plane_state->crtc;
>
> [Severity: High]
> Can accessing the global plane->state pointer here cause race conditions?
> It might be safer to use drm_atomic_get_new_plane_state(state, plane)->cr=
tc
> to ensure the correct state is referenced during the atomic commit.
>
>> +	struct xen_drm_front_drm_pipeline *pipeline;
>>  	struct drm_pending_vblank_event *event;
>>  	int idx;
>> =20
>> +	if (!crtc)
>> +		return;
>> +
>> +	pipeline =3D to_xen_drm_pipeline(crtc);
>>  	event =3D crtc->state->event;
>
> [Severity: High]
> Similarly, does reading and modifying the global crtc->state directly ris=
k
> fetching state from a concurrent commit instead of the current one?
>
>>  	if (event) {
>>  		struct drm_device *dev =3D crtc->dev;
>
> [ ... ]
>
>> @@ -331,10 +395,37 @@ static int display_pipe_init(struct xen_drm_front_=
drm_info *drm_info,
>> =20
>>  	formats =3D xen_drm_front_conn_get_formats(&format_count);
>> =20
>> -	return drm_simple_display_pipe_init(dev, &pipeline->pipe,
>> -					    &display_funcs, formats,
>> -					    format_count, NULL,
>> -					    &pipeline->conn);
>> +	ret =3D drm_universal_plane_init(dev, &pipeline->plane, 1,
>> +				       &display_plane_funcs,
>> +				       formats, format_count,
>> +				       NULL,
>> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
>
> [Severity: High]
> Does hardcoding the possible_crtcs mask to 1 restrict all primary planes =
to
> CRTC 0? For pipelines with an index greater than 0, the CRTC might fail t=
o
> find a compatible primary plane during atomic validation. Would using
> 1 << pipeline->index allow multi-display configurations to work correctly=
?
>

Will change possible_crtcs to 0 to populate automatically.

>> +	if (ret)
>> +		return ret;

