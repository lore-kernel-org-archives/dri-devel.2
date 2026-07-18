Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E069CC4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 15:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF17010E5C6;
	Sat, 18 Jul 2026 15:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9F6S0Gn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TSdtssAq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6E710E1E5
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 15:42:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66IDEBvY572102
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 15:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B3Tozc6XvAyXDRXhNm08ssVPc4HklhucZjeYpfFjPmA=; b=l9F6S0Gnb2vjgD6a
 NBQfReSJBOyCIXwIUgjQE9ha1CjdNnqVi17UErZCTYSlBRo/TxMbCbjqKp2d0Yy8
 2grbSegaeCpYWBsCtdZz1Mn3v8FEv1j5UcVICfCZoIiXa6CDvpkRuAbnTODcJZ/U
 B2BcXlqo9x1yKCfP3m63lMsLAwNF6umECQ3O2BYkakRH9Y3pltrWALui4/z2ZZDB
 Oohi70BkTEVI9LYX4Az4ZXFHWOAsSgFmcQVj/yBR+bc/KWRawPM7IARiYuzeczGl
 2Z7prJm/hdBFhaSSwCdQjPyC6p/fQJ948P1wqkX9Tl6bHTlDilZ5bfpKV/jZ9sV8
 GzU+Jw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvs24d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 15:42:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso5240992a12.3
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784389339; x=1784994139;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B3Tozc6XvAyXDRXhNm08ssVPc4HklhucZjeYpfFjPmA=;
 b=TSdtssAqAvdqW/wWDN3zwTZV8KsliIl2l4bLAOyGH4JEjDqp7OHvvxKoxD84c4SMD2
 xV/zgmZLX3ykNPmYla6VwFBaKYFattuem/Jocb0nscDUFjrYF3nFrWpeG+OsPCBIgZOW
 509Ypr/sd0oanWq+XawazCXHaGNfed9uocaPKGUyCNxbleTLsXNCMAxjwVwIVD9zpMAB
 I+YX31vRa1lZeophE3++4xqFZdhyEIUSo58P+KayWv5dIHweOtrYgRixN+F9WeN+Vtar
 ksU7+6W4LiKJOTtOwTYxrxZT5VoFF8hV0AirgykWr/rmpNVOOC8ZXWqL+UKCax7Mabpp
 Q1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784389339; x=1784994139;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B3Tozc6XvAyXDRXhNm08ssVPc4HklhucZjeYpfFjPmA=;
 b=H2gY4/qztlyq4ej+/hELk1JrCBxEAYK/J0H09/jgUvhytvpq6Le9n2q09m5rX1p2Bx
 6ylyYSkOKe2KaJR6ezaX61C6z7agJIKhQAQHPcHJnOzzzC6e8qup+/FgPXD+9UFRedEn
 li138xfDf8/X1aYbKE+gadNMQc4Qz2QZq1Ujwp6yANVlc7LEihub3VGMFVUQ1NHAyzlU
 CHdwCz69IG6SLBZwSbCCPoAv4DFb2gjyq1+rlbM1VRtI+BJcutXT6RHm+Xn/B7u6cTl1
 r9CP+gwqanD8UBbE+edDJ3bfFR/Z2OrVvA2EWRh19FnCAygH18Ns69dTA0VViNqSazep
 Lzlw==
X-Gm-Message-State: AOJu0YwpyBW3OE/h/USx3bcvH3blQpS0RBq4aYViiA+GWtg+bkIPEyKQ
 Y+oTLGBZfnOj/KBTCCARVhsKRqGrGZ6o4S0T+l9wHdCcYXV0hMfQWYbB1RhvMwUYX70pCGxxGaI
 nitZWuH8RTDF2/yF2YEMAXP46q1qU+g3m2onaUeC5gZ1WTC/2MgssBd4yNREqqFl+QIlu8Do=
X-Gm-Gg: AfdE7cnnPmkGJOPJDO9oWJYIZoW4WSDFTLwPaaV1uy5UHSjTepWtG0aHTGnOGokgEcE
 oneB1IIcCKELFC3kx6wHc/OSucFkI9/r2nMppKY1Fft4PH11hBrpj9TcGoSXWeyQ1ohGXNkURHp
 eBzSAuFJ03s29qvaeaBnNiLGCF+fE/VsGeXrwoN5n8PLaG1brP9PHVq/wy9611iZHtv1P8Untgl
 WPeZuYioA4aSP9qUNHhdvnDfqWwiIgoA5X75FwnKGsFOkS7FdyZv5np71dsWREfx4YnFSVNT0EI
 fLF2sVv6SbMQSSAEf6UG/wtVRn6oURYEvwcuR/NEIjr2lj7qLBghbZhd4Gsuoqy+tuYkX91Msp2
 QWlI37g==
X-Received: by 2002:a05:6300:95:b0:3bf:e2f1:1b08 with SMTP id
 adf61e73a8af0-3c3ad9717d4mr7925880637.40.1784389339429; 
 Sat, 18 Jul 2026 08:42:19 -0700 (PDT)
X-Received: by 2002:a05:6300:95:b0:3bf:e2f1:1b08 with SMTP id
 adf61e73a8af0-3c3ad9717d4mr7925851637.40.1784389338852; 
 Sat, 18 Jul 2026 08:42:18 -0700 (PDT)
Received: from localhost ([188.253.117.185]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d439sm22974922eec.5.2026.07.18.08.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2026 08:42:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jul 2026 23:42:10 +0800
Message-Id: <DK1T85P7OAAY.RXCY4AX71VRX@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-aspeed@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 5/8] drm/gm12u320: replace struct
 drm_simple_display_pipe with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Thomas Zimmermann" <tzimmermann@suse.de>, "Ze Huang"
 <ze.huang@oss.qualcomm.com>, "Alexey Brodkin" <abrodkin@synopsys.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Stanley" <joel@jms.id.au>, "Andrew Jeffery"
 <andrew@codeconstruct.com.au>, "Frank Li" <Frank.Li@nxp.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Linus
 Walleij" <linusw@kernel.org>, "Hans de Goede" <hansg@kernel.org>, "Alex
 Lanzano" <lanzano.alex@gmail.com>, "Oleksandr Andrushchenko"
 <oleksandr_andrushchenko@epam.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
 <20260716-drm-simple-kms-removal-v2-5-1133a8fc3785@oss.qualcomm.com>
 <26981ae1-4aef-4965-8600-f5e30a1b564a@suse.de>
In-Reply-To: <26981ae1-4aef-4965-8600-f5e30a1b564a@suse.de>
X-Proofpoint-GUID: okqdhAcYK0wWqBUMHANqN5ECR0rpXhLN
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5b9edc cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=RQ3dwY0XcLBFaqRX7rIGyg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ZBS7nKAnUslcPLfxFb0A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDE2MyBTYWx0ZWRfX2ohO/wm3Oj/n
 1FVU7rEoncUxdSTLQlW+mTgZ6d/4nOFaZT9XbYf/kI2GWhDc/pSBBrPoejgrcb5sXvmAyRVOvF3
 srTDPFNAOnHahexwR38/LX9cAW0jxyxJDvdWeWnF/yT/YNX+PpNyRo6X1wscbhBnC1Gv98gIzJe
 g6waa/L0uaCD7xZuSULeYNgjc5/2wVrL7bfIEq/ueBEr8HE7W+x1336c5cWTu3+Eiu8hFF3TZJ0
 9vidWqVZBw7iKYxPa1esc3iyViG9VN0USB0Rb+D0NoElosCk3u6azJT0MDeNAJrDbDDixhEspyI
 nOAuKeV8faaBLPTiU5bKgFd+asWEZYyX+WMzLEFO4yloNIYyc3aJFte22GAA3Sr+CaLyhePLWh4
 aePjSpJ5k8kl84Q//JCqJUQmYHlVpL/V66nuJzJG1VGIKZSg8emj6OJWwQ/kTrtAtLcv2jkxOgj
 7OgOfSBwJYK81bWbYeQ==
X-Proofpoint-ORIG-GUID: okqdhAcYK0wWqBUMHANqN5ECR0rpXhLN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDE2MyBTYWx0ZWRfX3WIu/megkuZO
 VkeV2VkF/Pw8lS+34UTdWv2n4El8af/3wdgqAI7JaMqmanQ+DJYsSXd8NcBa337X0dwj72BdPZq
 0EzA1jYwwYaOWLaSVXUcc0eMSxlMVDs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180163
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

On Fri Jul 17, 2026 at 3:18 PM CST, Thomas Zimmermann wrote:
> Hi
>
> Am 16.07.26 um 11:01 schrieb Ze Huang:
>> Convert gm12u320 to direct primary plane, CRTC and encoder setup.
>>
>> Keep shadow-plane helper state, framebuffer access helpers and
>> no-scaling plane-state check from simple-KMS path.
>>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/tiny/gm12u320.c | 132 ++++++++++++++++++++++++++++++++=
--------
>>   1 file changed, 107 insertions(+), 25 deletions(-)
>>
> [...]
>>  =20
>> -static void gm12u320_pipe_enable(struct drm_simple_display_pipe *pipe,
>> -				 struct drm_crtc_state *crtc_state,
>> -				 struct drm_plane_state *plane_state)
>> +static void gm12u320_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>> +					       struct drm_atomic_commit *commit)
>>   {
>>   	struct drm_rect rect =3D { 0, 0, GM12U320_USER_WIDTH, GM12U320_HEIGHT=
 };
>> -	struct gm12u320_device *gm12u320 =3D to_gm12u320(pipe->crtc.dev);
>> +	struct gm12u320_device *gm12u320 =3D to_gm12u320(crtc->dev);
>> +	struct drm_plane_state *plane_state =3D gm12u320->plane.state;
>
> Did you see the reply from the Sashiko bot?
>
> What happens is that user space can apply multiple atomic commits in a=20
> row, but they are applied to hardware asynchronously. So if you take the=
=20
> plane state here directly from the plane, it could have been replaced by=
=20
> a later atomic commit already.=C2=A0 Rather get the correct plane state w=
ith=20
> the helper drm_atomic_get_new_plane_state().
>

I think I misunderstood this point. I had assumed that
drm_atomic_get_*_state() was only needed for the state object directly
matching the helper callback, for example crtc_state in
*_crtc_helper_atomic_enable() and plane_state in
*_plane_helper_atomic_update(), while other state could be accessed via
the device-private structure.

From your explanation, I see that this is wrong. In the atomic commit
path, any state associated with the current commit should be obtained
through drm_atomic_get_*_state(), because the object=E2=80=99s ->state may
already refer to a later commit.

> I did not look at all of the series' patches for this problem, but the ru=
le
> applies to all of the mode-setting code.
>
> Best regards
> Thomas

This affects other patches in the series as well, and some drivers may
need additional fixes in internal helpers too, e.g. arc_pgu_set_pxl_fmt()
in arcpgu.c [1].

I will audit the full series and fix such cases in the next version.

Best regards
Ze
