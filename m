Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1EBC4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 17:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F7710E5D9;
	Sat, 18 Jul 2026 17:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hmFR5E0X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N32J2bYw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D995710E5D9
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:52:50 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66IGPTi81347556
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ClAQZqqpLrSxh/ilTgA975QpkExyJZmFR6ENFCfm7tI=; b=hmFR5E0X/+1xE8EW
 qd3ZPOT5/IAiqwzLyYhjTjLTveCAW77lVphkLvzn9l1iua5G/HJ1p+6IFxAGzDnU
 hQiZlK+/AyENuM9ndPkeGU5owVIa/tl16ycykf45J27jKP9UCvGeEtLDGmV578sS
 GDrn/M2DCmPNGp6om6Fmbfg3cBHnvlLpWlLMSIMCys1/vv9SZYldDCWewLBtk+qX
 vKY3fDK/WQ+gTrJkWL3zYWkNImprLTBbPzujsSBXoT2BH/tH81AWjYGTGWJmhKCG
 BAF1+JOY64FvG3Cpn3NqxPVcsfoOc2E3WUatEUGuplXM48coZMbxiZbkp/npysLI
 iYrKvA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d91852-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:52:50 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca124bf0189so1616998a12.0
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 10:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784397169; x=1785001969;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ClAQZqqpLrSxh/ilTgA975QpkExyJZmFR6ENFCfm7tI=;
 b=N32J2bYwy9NwGrdjVMDu178T+Y0+e/Lf1hD7Zn8049qJipe9rhqCw+t9yvhK8kf++Q
 Ww7B5BNwO9l2GW1fBgozWIhPoJtRpexFX4uYTRsDrvTLCnrmjqzKD+U3U4vz8gcZSEMz
 4Mz3h7OS0JJuT02SR3wd+GeIUwlkA4uqI9cosZSP/6kxL/XACYX6n6A8tQU+cPTcwL5h
 m0Qy/K/Azug2/42gRF+rV1HRtI0TYsNoNbGHxanuwH0b83O8w5EPqmzQfr/qdWJHAiiJ
 wnJuiFHLnnsaef+HB/hJJAs71S8WHNPa4MfW11ALTwKloEWTJwOcKHup2IN1KFoeZ/9q
 VtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784397169; x=1785001969;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ClAQZqqpLrSxh/ilTgA975QpkExyJZmFR6ENFCfm7tI=;
 b=gEohcx5Bhse3qFbWmNbq0iAU2yY3+4cB4HMFONtfQaI7Q0+Ee8ClaLu/9nM+hVupe8
 gbmf+OsUfhIk2Dejqs+gEfCBYtmOJJFLTVNDV6DlSsDfqK1UJ7XP6Ax4UPu6eMsFlI++
 vMer0qFUSDaCsBuWDl/sjY0+jsVnN33/4DEnz+hjkqwNABC6UeoeC4YUnHgrbHpm4KWj
 2zVuTVaq46PrT00J0o1HPj/wkStExVVLKFAvgEL7Oz0wCDdj5lFg7U6Vms4mYsbOYej/
 EfAxhelLATfo+8jP2nzwe8wDdPGk7hluYLe4uJIKSvfLoDvqlJBNr3slg3HudqBquZu4
 vZkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6lOmubu3DrytZzNacSYQMNoRBo3iATFAWJZf/8sCTRlWkzR9QlJ6r/J9lIlw58a6V8OgVdWTHk7k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgqdJWx1mpBAvlvkVgOq3xXWHf/5lV/TnrkqH5d/8jqNV3vjtI
 C/aZIEFbI5c6hjWEuT74w0SRR+Fhu9TU9A8+P4PthfCfZeVEB/PQLOvQ97gcadF1SCawTCa8p+z
 lGoWH/8h43QOtvQbdBWt0ci50hWz3wJBsMN10y1mZLOTrOYU+9vjEFvu8FZHmPJbabzAKvEs=
X-Gm-Gg: AfdE7ckdtTypO4nJuY8fB+SV1O7NxmnGHEFH9WXz7TDoJllGTbeuLhYeHrDeTcTmaB8
 ELg4IlUS+Vn5k17fDcz/QLru57eDLW0qh4rPpShE7pA+K7MHvzr7TCzvOBv23nINSRQvpv4Twqo
 Vabcv63SjJUeMinBwTS9G6FjKpSA5vqS1GQHgGxlzf5zA2LJHDkYQHaf7NcbrH7V/W5LUFmqNw5
 TH1XFp6Zfply383Is3V8PLuvuIcCB1fmnKJwOZf05hrh7R73aiJ+FQpbTdsazgdfqUH0KfcLbrv
 Aevl4D5XsdGElTxI/YAFaj8Dq16m132Rsdsn9BaRPrXDg+vQoCzfVgS7FLmxxRqZuFYq4NV/6ke
 0ZttDiA==
X-Received: by 2002:a17:90b:590e:b0:387:d5bd:622f with SMTP id
 98e67ed59e1d1-38e4b691d21mr6469914a91.18.1784397169401; 
 Sat, 18 Jul 2026 10:52:49 -0700 (PDT)
X-Received: by 2002:a17:90b:590e:b0:387:d5bd:622f with SMTP id
 98e67ed59e1d1-38e4b691d21mr6469894a91.18.1784397168875; 
 Sat, 18 Jul 2026 10:52:48 -0700 (PDT)
Received: from localhost ([188.253.117.185]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d439sm23819967eec.5.2026.07.18.10.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2026 10:52:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Jul 2026 01:52:44 +0800
Message-Id: <DK1W04LF68WN.3LEHUKMBX3JJO@oss.qualcomm.com>
Cc: <imx@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <Frank.Li@kernel.org>
Subject: Re: [PATCH v2 3/8] drm/mcde: replace struct drm_simple_display_pipe
 with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: <sashiko-reviews@lists.linux.dev>, "Ze Huang" <ze.huang@oss.qualcomm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
 <20260716-drm-simple-kms-removal-v2-3-1133a8fc3785@oss.qualcomm.com>
 <20260716092109.A755F1F00A3A@smtp.kernel.org>
In-Reply-To: <20260716092109.A755F1F00A3A@smtp.kernel.org>
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5bbd72 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=RQ3dwY0XcLBFaqRX7rIGyg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Xo--NF9sZlCFNlXQFFYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 4pJYuvbZWOYCwJ5whynzbbvIiLa6XsME
X-Proofpoint-ORIG-GUID: 4pJYuvbZWOYCwJ5whynzbbvIiLa6XsME
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDE4NyBTYWx0ZWRfX+gu+YNBlbZRB
 li5gJfo49G1wTledC6+tSq5cf4rt9qR09Ci+eN6EOxyo4DTBj8KK0PZrVdcEL+/etMTpLli+Lgp
 e9vtZF2SIB0r/DYtUP0rYd9FBXkSKrdS4RR5lH5s5AGwJ6ZvDU+uzPkXG6dzSK2h1S6eJsz6zk6
 jcf5O1534TOoPffndzpRTRi3c1GwA+5k98LnsJHfTmuxam3uJKHryjhBzm52TIZlF9L8WZQ5nOv
 +WJ+XsvvwDzQySRMST/p5nBnGlgNDwqRpCwQe5ONCmpujmCMe/vVKTNeiMn+SG6k2JQ6VaA9Vn+
 for1iahhqVQ2QU6X3OASK6C64X2NR/gzo88zASSud1ZWFCcwciKOBhHv4eI/SRenLWlrZHpE4Ck
 bB3H26mHx6t34Lu0O6EBiokW8rm1WuB3EMmfdry74/v+z6veoim1cUADX9IviT69xt7blVSQWvj
 3oF7AsVCzaBzUW673pw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDE4NyBTYWx0ZWRfX/nMmnklE+4qr
 2sk2MYc5nv/TTqZibGlv9iD3sQUGDpkAh20kdb54PnYXjqgL4cOQWxtXByk1iMkpiXs17j4FN9z
 82C2sraCSy86feoKVd5S4ATrMHZ0qhk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180187
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

On Thu Jul 16, 2026 at 5:21 PM CST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Race condition in atomic commit causing display hang in oneshot =
mode due to premature hardware start.
> --
>
> --- Patch [3]: [PATCH v2 3/8] drm/mcde: replace struct drm_simple_display=
_pipe with regular atomic helpers ---
> commit 24a767bb6a2c4adfefe9e0a5de7e9c8bbe7b2a64
> Author: Ze Huang <ze.huang@oss.qualcomm.com>
>
> drm/mcde: replace struct drm_simple_display_pipe with regular atomic help=
ers
>
> Convert MCDE to explicit plane, CRTC and encoder objects. Handle pending
> page-flip events from the CRTC atomic flush path using the commit-local
> CRTC state.
>
>> diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/=
mcde_display.c
>> index 257a6e84dd583..86edf94c52372 100644
>> --- a/drivers/gpu/drm/mcde/mcde_display.c
>> +++ b/drivers/gpu/drm/mcde/mcde_display.c
> [ ... ]
>> @@ -1381,44 +1398,13 @@ static void mcde_set_extsrc(struct mcde *mcde, u=
32 buffer_address)
>> -static void mcde_display_update(struct drm_simple_display_pipe *pipe,
>> -				struct drm_plane_state *old_pstate)
>> +static void mcde_plane_helper_atomic_update(struct drm_plane *plane,
>> +					    struct drm_atomic_commit *commit)
>>  {
>> -	struct drm_crtc *crtc =3D &pipe->crtc;
>> -	struct drm_device *drm =3D crtc->dev;
>> -	struct mcde *mcde =3D to_mcde(drm);
>> -	struct drm_pending_vblank_event *event =3D crtc->state->event;
>> -	struct drm_plane *plane =3D &pipe->plane;
>> -	struct drm_plane_state *pstate =3D plane->state;
>> +	struct drm_plane_state *pstate =3D drm_atomic_get_new_plane_state(comm=
it, plane);
>> +	struct mcde *mcde =3D to_mcde(plane->dev);
>>  	struct drm_framebuffer *fb =3D pstate->fb;
>> =20
>> -	/*
>> -	 * Handle any pending event first, we need to arm the vblank
>> -	 * interrupt before sending any update to the display so we don't
>> -	 * miss the interrupt.
>> -	 */
>> -	if (event) {
> [ ... ]
>> -		spin_unlock_irq(&crtc->dev->event_lock);
>> -	}
>> -
>>  	/*
>>  	 * We do not start sending framebuffer updates before the
>>  	 * display is enabled. Update events will however be dispatched
> [ ... ]
>> -static int mcde_display_enable_vblank(struct drm_simple_display_pipe *p=
ipe)
>> +static void mcde_crtc_helper_atomic_flush(struct drm_crtc *crtc,
>> +					  struct drm_atomic_commit *commit)
>> +{
>> +	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(co=
mmit, crtc);
>> +	struct drm_pending_vblank_event *event =3D crtc_state->event;
>> +
>> +	/*
>> +	 * Handle any pending event first, we need to arm the vblank
>> +	 * interrupt before sending any update to the display so we don't
>> +	 * miss the interrupt.
>> +	 */
>> +	if (!event)
>> +		return;
>
> [Severity: High]
> Does this split introduce a race condition that could hang the pipeline i=
n
> oneshot mode?
>
> Because the DRM core executes the plane's atomic_update callback before t=
he
> CRTC's atomic_flush callback, the hardware flow is now started before the
> vblank event is armed.
>
> If mcde_start_flow() is triggered during mcde_plane_helper_atomic_update(=
)
> (which happens just below the quoted block), it could complete the hardwa=
re
> transfer and fire its interrupt before the vblank event gets armed later =
in
> mcde_crtc_helper_atomic_flush().
>
> The relocated comment in atomic_flush still notes this exact requirement:
> "we need to arm the vblank interrupt before sending any update to the
> display so we don't miss the interrupt."
>
> If the interrupt fires early in oneshot mode, it will be missed, and the
> atomic commit could wait indefinitely for an event that will never comple=
te.

Hi, Thomas

Would it make more sense to move this pending vblank event handling to
the CRTC's atomic_begin(), or should it simply go back to update()?

From the comment in the original code, the event needs to be armed
before the update is triggered, otherwise the completion interrupt could
be missed in oneshot mode.

Thanks,
Ze
