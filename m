Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3C7C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 17:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE8210E24A;
	Sat, 18 Jul 2026 17:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gtPQwwYd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R7AFVX0d";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C859F10E24A
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:15:40 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66IGOOBe1262569
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S02lmnDkxR99M4VaqTHSbP6f3vLxjenlZmJ2G9hkEFs=; b=gtPQwwYdfxQMiJ5o
 uCg+4G4yykaWgo7djVy/y8MHfV9DDoaN0VZv15VNzXhZyyA/B43GiCAQr4REySaz
 qKQMUIPOEuYxb6outlxKcBdrJY4hlyYVTpyJV0YwSkPLSSufuhN8SBokVu9tVySz
 OXTnLBS0WaKK+MqIHCCP4i1BXhPxgeyj63YKysHiwT6LWA/mlMhnr0lqMHDT7pN6
 15DNlVzkVlg5U3R+FvPi++IlJrSRK1h0hsUhobSGLZWxBVhIVbR4+Ckez8Zm23fw
 0kU9437Vjq9ghC0gFzNDDvulhjGMs6NStMNd/P3VsF3kIaVCKIlpyPuL4toXIPUB
 Sbg1cg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2c696ps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:15:39 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e70ae557cso36272a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784394938; x=1784999738;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S02lmnDkxR99M4VaqTHSbP6f3vLxjenlZmJ2G9hkEFs=;
 b=R7AFVX0dmTV4ojAQM23B8LjO76s+GiYU/VdFRMWdhCWHJkkkI49RXcYzDI1OopiNFo
 IIoNZT7KGWJ0MKYgghuw2a3ScBapCXeWxwxIsDn85b0HYRiNKnikN2w1ASkb8ujoaGWv
 Y7D35hd5dBiL7aG1PzN7L4N2ODLwOvG1oTnyxZtaFO1/RlSe6h2h2paPQ6nj3kZhV0ze
 Wsnc6Rc+VPrMwwpWJ/+bStVWDRLZ2YKArKDwMFf4hF94RGfQJkIvDndgaHaGXbRmqo9y
 VegszYSOAV4TRH0mXkSCiOdAnJrfspqaMt4JEPhAIncf7bAKW/wdBzvojxeP9dCR+aAv
 +EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784394938; x=1784999738;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S02lmnDkxR99M4VaqTHSbP6f3vLxjenlZmJ2G9hkEFs=;
 b=NVmduhTFSGxF1Rac2TDQetiRdY4/sRvbYMvnvhelzWtB8ahwSmX6PytsikgbQLZmAQ
 dFS1dnjaDz8c0bUKQUFEmAUFizv6N+Vy1+Owg/ONv9FozU+lzaPKKs4agHAeTOQHLeTs
 fs6dTFdeasIhqarXRgqT12QSlmo2d+jxoAts2YQCWyzviQXG5SKc3NSe7RqnLiXkdEE3
 sPyTi0yfnvoiKKSVLayC4g0BExbjYr4KSrTQQ5viXQnDXIdUrSwcvhONlM5WTnRLx26b
 3Ew1YhteSBA7khGSYF+zq4OHgwVQ2bmeIt0RXTpnOJuHeQpaLua1MH8mNI3oP33t3NO/
 SSCw==
X-Gm-Message-State: AOJu0YyKK8787pefsMdnsEOKRbgkI6/ic+3O3mU/tDafaAXePIr6bbAJ
 URB+Fg1Vdqsh6y9yy7QxAJg7H9BT564yb62Nkfr9A5/5YzSYAhdAdTalCo3Rg7xbVoOV6ARO6bS
 x5ujuIpY7RVBHIZ9d0MjB7DIm3ZGe5w1qSuVizm5AnbzVYnylkZotkuRemINGEUUv4u7dHAw=
X-Gm-Gg: AfdE7cnWNXI9erYv/C7VkrIAcfAq1I8jklgoJRgMv85Wip2VwglK+6hS+kf/WxIrchJ
 QUnczv+afzyB6WMfLBWfso+BUJ7EsWI6XltUNp6N0KuETgp0HJxhY6LvGsDZa0bT7cBdwSY2dAV
 kNidvBhWLXFb2EA8fqtxahMw9L/9Qegxbu/EPgxwLlugY3Wq67bEDCgJbxbMXsmkLCqMSBR+pgS
 QkE0DZ+Y/aGwMk4QR32dOHyCvNstY2AMMCeGzqRL24Jc53ONOEzwEZb1Y7YPf1zl4nIoF5sKVCN
 QzmGMx8yvhYWKAnJNsoDoY9kKiDMQUETrMoErELwcQqDsAOpyLkkhkxsZ/YZaE9WqtAsU5mJzJ3
 ct/cW7w==
X-Received: by 2002:a17:90b:6cc:b0:387:e0bb:57f4 with SMTP id
 98e67ed59e1d1-38e4b5792a6mr8316259a91.37.1784394938090; 
 Sat, 18 Jul 2026 10:15:38 -0700 (PDT)
X-Received: by 2002:a17:90b:6cc:b0:387:e0bb:57f4 with SMTP id
 98e67ed59e1d1-38e4b5792a6mr8316231a91.37.1784394937552; 
 Sat, 18 Jul 2026 10:15:37 -0700 (PDT)
Received: from localhost ([188.253.117.185]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429fe4677sm17263853eec.11.2026.07.18.10.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2026 10:15:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Jul 2026 01:15:32 +0800
Message-Id: <DK1V7NJRAMW0.2LI6ANJZPVX0U@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <Frank.Li@kernel.org>,
 <imx@lists.linux.dev>
Subject: Re: [PATCH v2 1/8] drm/arcpgu: replace struct
 drm_simple_display_pipe with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: <sashiko-reviews@lists.linux.dev>, "Ze Huang" <ze.huang@oss.qualcomm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
 <20260716-drm-simple-kms-removal-v2-1-1133a8fc3785@oss.qualcomm.com>
 <20260716091533.1C6691F000E9@smtp.kernel.org>
In-Reply-To: <20260716091533.1C6691F000E9@smtp.kernel.org>
X-Proofpoint-GUID: KQrx3rhSntApSdOiukOIbE0bqCVhldrB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDE4MCBTYWx0ZWRfX+7/qmZ0WcDwJ
 PLoqv++8ehneULsn/8+4xOjtKfq4Sh1+E85xrXdur6/WhOZ+FR/z+vdbt74nouioXt1EQGAqAEs
 7l4N+DxLFaviVLoZrbQgHPThpb5XJXPEyv+bjeE0lqyQkcE2D4O6+k6iafQesvQsktYP2lYxQuD
 k7t0BOkXIAdvKMW2OEJ3pMFU0HdF5c9uvoL4upb1hZe3SebxPmjbvdJY+9ElnJZJQ2DbMt5Q6Cc
 dMf+8Mnx6yZEz0U78Sq4vBIWpLk5ixqBacOdgLRkbQ7gYqFz3wcMJI0TYpUv/PsLWPo7JO2i4Kw
 m5apdleIX/c7EwK1cfVhF2IoZV5vTTP5tt/XNsSaV8T/uMpTBX6mitVroVViWWmopTt/Ld5I7Na
 WWxvOxG2GsII2lEyN1EjlPkfdf0B4G7GHOrWJmVWtUJBqAXSwKQ0AxnfbkOwgTon345c4g5kWrH
 gQCXIa/krcJuRDjZZTg==
X-Proofpoint-ORIG-GUID: KQrx3rhSntApSdOiukOIbE0bqCVhldrB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDE4MCBTYWx0ZWRfX4vqJ4Chfrwwl
 MsT6Q/iR+ri5eWUpXDW5WblqAZaKk//LobHX77WeQGN+QbAbnsfwBqp922Pk9OPavn9HQr8fW+n
 /n6n8kWzogzZBcxtDDzphGKaoKMmMgc=
X-Authority-Analysis: v=2.4 cv=CJQamxrD c=1 sm=1 tr=0 ts=6a5bb4bb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=RQ3dwY0XcLBFaqRX7rIGyg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=3AJc28u4kSigJocD1w8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180180
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

On Thu Jul 16, 2026 at 5:15 PM CST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] Use-After-Free in debugfs when reading CRTC state without a lock
> - [High] Unchecked `encoder_node` passed to `of_drm_find_and_get_bridge()=
`
> - [Medium] Dynamic pixel format changes will not be programmed into the h=
ardware
> --
>
> --- Patch [1]: [PATCH v2 1/8] drm/arcpgu: replace struct drm_simple_displ=
ay_pipe with regular atomic helpers ---
> commit 053328e64a955beacd393bc82052adf8a231ec8a
> Author: Ze Huang <ze.huang@oss.qualcomm.com>
>
> drm/arcpgu: replace struct drm_simple_display_pipe with regular atomic he=
lpers
>    =20
> This replaces the deprecated simple-KMS display pipe interface with regul=
ar
> atomic helpers. It instantiates the plane, CRTC, and encoder directly.
>
>> diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu=
.c
>> index c93d61ac0bb75..e0cce4798f3ed 100644
>> --- a/drivers/gpu/drm/tiny/arcpgu.c
>> +++ b/drivers/gpu/drm/tiny/arcpgu.c
>> [ ... ]
>> @@ -218,35 +223,95 @@ static void arc_pgu_disable(struct drm_simple_disp=
lay_pipe *pipe)
>> [ ... ]
>> +static int arcpgu_plane_helper_atomic_check(struct drm_plane *plane,
>> +					    struct drm_atomic_commit *commit)
>> +{
>> +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state=
(commit, plane);
>> +	struct drm_crtc *crtc =3D plane_state->crtc;
>> +	struct drm_crtc_state *crtc_state =3D NULL;
>> +
>> +	if (crtc)
>> +		crtc_state =3D drm_atomic_get_new_crtc_state(commit, crtc);
>> +
>> +	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
>> +						   DRM_PLANE_NO_SCALING,
>> +						   DRM_PLANE_NO_SCALING,
>> +						   false, false);
>> +}
>
> [Severity: Medium]
> Will dynamic pixel format changes be programmed into the hardware with th=
is
> check?
>
> When a DRM client issues an atomic commit that only changes the framebuff=
er's
> pixel format without changing the display mode, this function delegates t=
o
> drm_atomic_helper_check_plane_state() but doesn't check if fb->format
> changed.
>
> Because crtc_state->mode_changed isn't set to true on format changes, and
> the hardware's pixel format register is only updated in arc_pgu_mode_set(=
)
> during atomic_enable(), does this mean the hardware might continue using =
the
> old format and cause display corruption? The previous simple-kms helper
> handled this by forcing a modeset when the format changed.

This does not appear to be introduced by this conversion. I'd like to
keep the old behavior.

>
>> [ ... ]
>> @@ -285,6 +353,30 @@ static int arcpgu_load(struct arcpgu_drm_private *a=
rcpgu)
>> [ ... ]
>>  	/*
>>  	 * There is only one output port inside each device. It is linked with
>>  	 * encoder endpoint.
>> @@ -293,29 +385,24 @@ static int arcpgu_load(struct arcpgu_drm_private *=
arcpgu)
>>  	if (endpoint_node) {
>>  		encoder_node =3D of_graph_get_remote_port_parent(endpoint_node);
>>  		of_node_put(endpoint_node);
>> -	} else {
>> -		connector =3D &arcpgu->sim_conn;
>> -		dev_info(drm->dev, "no encoder found. Assumed virtual LCD on simulati=
on platform\n");
>> -		ret =3D arcpgu_drm_sim_init(drm, connector);
>> -		if (ret < 0)
>> -			return ret;
>> -	}
>> =20
>> -	ret =3D drm_simple_display_pipe_init(drm, &arcpgu->pipe, &arc_pgu_pipe=
_funcs,
>> -					   arc_pgu_supported_formats,
>> -					   ARRAY_SIZE(arc_pgu_supported_formats),
>> -					   NULL, connector);
>> -	if (ret)
>> -		return ret;
>> -
>> -	if (encoder_node) {
>>  		/* Locate drm bridge from the hdmi encoder DT node */
>>  		struct drm_bridge *bridge __free(drm_bridge_put) =3D
>>  			of_drm_find_and_get_bridge(encoder_node);
>
> [Severity: High]
> Could this lead to attaching an unrelated bridge or indefinitely deferrin=
g
> the probe?
>
> In arcpgu_load(), if endpoint_node has no remote parent, encoder_node wil=
l
> be NULL. In the previous code, the bridge lookup was guarded by an explic=
it
> if (encoder_node) check. Now, of_drm_find_and_get_bridge(NULL) is called
> unconditionally.

Yes, it is possible

>
> If a NULL node is passed, the bridge lookup iterates through registered
> bridges and might return the first bridge with a NULL of_node, incorrectl=
y
> attaching it. If none are found, it fails with -EPROBE_DEFER, which might
> leave the system without a working display. Should this retain the
> encoder_node check?
>

I'll check the encoder_node after of parent get

    encoder_node =3D of_graph_get_remote_port_parent(endpoint_node);
+   if (!encoder_node)
+       return -ENODEV;
    of_node_put(endpoint_node);


>>  		if (!bridge)
>>  			return -EPROBE_DEFER;
>
>> [ ... ]
>> @@ -342,7 +429,7 @@ static int arcpgu_show_pxlclock(struct seq_file *m, =
void *arg)
>>  	struct drm_device *drm =3D node->minor->dev;
>>  	struct arcpgu_drm_private *arcpgu =3D dev_to_arcpgu(drm);
>>  	unsigned long clkrate =3D clk_get_rate(arcpgu->clk);
>> -	unsigned long mode_clock =3D arcpgu->pipe.crtc.mode.crtc_clock * 1000;
>> +	unsigned long mode_clock =3D arcpgu->crtc.state->mode.crtc_clock * 100=
0;
>
> [Severity: High]
> Does this introduce a use-after-free risk when reading the CRTC state?
>    =20
> In arcpgu_show_pxlclock(), the new code accesses arcpgu->crtc.state witho=
ut
> holding the crtc->mutex lock.
>
> If a user reads the pxlclock debugfs file concurrently with a display mod=
e
> setting operation completing, drm_atomic_helper_swap_state() might swap o=
ut
> the old CRTC state and free it asynchronously. Dereferencing this dynamic=
ally
> allocated state pointer without synchronization could lead to a kernel oo=
ps.
>
> The previous simple-KMS code avoided this by reading pipe.crtc.mode, whic=
h
> is embedded in the CRTC struct itself and updated safely for legacy acces=
s.
>

I'll lock it first

    ret =3D drm_modeset_lock_single_interruptible(&arcpgu->crtc.mutex);
    if (ret)
        return ret;
    mode_clock =3D arcpgu->crtc.state->mode.crtc_clock * 1000;
    drm_modeset_unlock(&arcpgu->crtc.mutex);


>>  	seq_printf(m, "hw  : %lu\n", clkrate);
>>  	seq_printf(m, "mode: %lu\n", mode_clock);

