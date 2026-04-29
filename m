Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36935FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 01:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC1D10E3D7;
	Wed, 29 Apr 2026 01:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K7vnImj6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UL8SHCIR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC4E10E3D7
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 01:54:22 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T0oHf92008532
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 01:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=hl+lm4GyDtdr7iMFEoha/39D
 wXm/4Uwgmobplc35OLk=; b=K7vnImj6wKWVe6AfnduJF3bmaaumQHOQxhchubUN
 iMmjZwbu+gqDOuBdRMSlgekHGZwSroAaBs/nMnL2YJ9wba65pWNYpdxTokCpfgW4
 bNRz+6iEjkm1XVBJ3+6vP1VRkUZyGftyO+/EMXPapqe+xn1S+pPEU8Ou1mF/uyWf
 WDipwfep7OEKTVLc0GW8MlcsJwic5dMrYiqVWh6tLeiOeMmVPCkPwIID58cxGMfD
 13u2q89fvyXo0MtKsHVtjJAhY1DQeBKonGGjvcRmWzbxQa42EOBqrpmDn5kOFuzQ
 ESWSCtAQ35q2/qLBYWDKO0WjuVz7EnELjN9DxNAsSGesNQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sx85gr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 01:54:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35fb969a4c0so12976614a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 18:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777427660; cv=none;
 d=google.com; s=arc-20240605;
 b=hV7zR+2TlkC5ouhfS3+mNjwE9+/YaTJIvLahLN/r5I/gfVly/voMXnVDDmh8LdRwzX
 FbKl7LbFZVgNQWhWvmFmxm7zgaDo4FYxKf8HQh96Pd96cP+5VDzTuxRRIlGpEIaYAIlO
 tLrEd66y0CpfMpDUos+BybrX94OFKYkFn3/9KwTsYf+7LfVDEqEp8Z7xM98OaGmO1CUs
 BXoHsKhX6eoZhurnac6uYWQW2ZYnj91SFfZqDTCgaznxUAgFTfjeaOneM/8hOnQ8Bi9H
 9N5zzh2tkRrC13ZuU9gQsMvm/YaSrNMS5eWExi8xToc0G4YgVXTCXorh5DLDw9nZ15ql
 MsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hl+lm4GyDtdr7iMFEoha/39DwXm/4Uwgmobplc35OLk=;
 fh=jlTjx3M3OEzEIWNpMePbjZC0Rjsc07W/XV53jG0gYTU=;
 b=NuejqbvqN0Ibk4Lwn6bR6d1nOStt4XaCACicWbK+jwYdB63XHfRPWckMBNLUMf97mh
 9abF2srEC6EITEmrfCh5n1ITSA5nibKkRXF/rxlxSCQL0xWpkbPuy7xW+ryDZ1BiKhW3
 LRBw3GATY+9lezS3vxxBUEV0HSrkdgO1k5o9tWTg7vaGYHU7MvfNwpOWV5ZeNSIxAmzH
 1nEJqINWAHxa1cxIbW4mQ463EcLayX8Zlzya/iOTNT2ogRYoawE0ghHfIV/iDBf8w12m
 gCRKgjyuf/Jq2FGEmkY8XPTJYjaqS2RkzfIGOSvRzKkryeLFk/UW2DjNVgOIXMFFMZkE
 CA9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777427660; x=1778032460;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hl+lm4GyDtdr7iMFEoha/39DwXm/4Uwgmobplc35OLk=;
 b=UL8SHCIRCboFkofTRuG6z5cBemsbjlB4HiFg8Z7XM2gkEC7qVzGLuEvVu3p37cqqWO
 37BqzQtk+RQi1uJ5OqBnO9pymref4dFE+H+Bcxe+6JxDlmxQmFeeYaX5EMG6EqpFv6uM
 U+m4AcRu4JfCTJyjJx9eARez8ql/E3roFucuOjgrkqVcnsHhb5ZU4kCtUP0F+qs+fMlz
 mVMSya0bJ0jIjfPlLK8Acire0Ntx6AGbA7ESSxqMlX1dJk5lfaUn3la34vSQy4UmIaxE
 FFLakBVcXrxzUUBKUnrpUqtinAj0zYG7w0x0XsPOCcO+bSi+3tQ4D0fJ6q2jvkyunftt
 EquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777427660; x=1778032460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hl+lm4GyDtdr7iMFEoha/39DwXm/4Uwgmobplc35OLk=;
 b=mMyE0DEnr5fh9v2bM+iRnoHAtOomFXvE5D8UFK6rYtAYykD/HQvTJ+irQtgKrZZU3A
 16CvCTJufiNu1abW0cj3XHGEknqKfeKD4PQCgpY+zqnBbC10LiLfDdpHiI+zIQz3CdMh
 pcqHW1mAhA415H4butAG30/WEprRXRe44bnWjfA4el2e5l7n8NysulbiiV8oP42y/KMU
 hmU9X7vP5YlhGUG8EhEC8hcECDcS10z/BgS8SzqSUtQzr112hGU8mtOTDGyEiUDCNKVI
 rKQtISiHQYRWhzPc8ycLhfpqZPsh4jXimATK7lUfU/yhzOI6sNxqxDesiU7ZGik8dvaM
 +mYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+29Op3oQ5WGnHyjJwwmI5cqoZ5pFAcP0eTvDJOmkmj+wy9hJvtmz5UeSdRscAZ3gljugn/xar40d0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDMRplM4NVHZ0lbVPCO1z2A1qFiZhTkSvs/Ef10OuemD+iBGyY
 swlrTgrV1i+sBqsBrZj6NZ0YrYWYztMGoM/dL3NBOOJVEybllAwAgfpUa/Tx1H3T2GpEpLpxj5w
 srdkbanpXViNlk1vmS9Ac1Lf4jV9/UJaZn3jLKpUMXxMJPvqOvoDJH5/tAVWAXBmS0xvhwvtnAy
 zikSlvbJYJCfoSe+jCD+zrWkWlI1RQWz+7/mqaWtL6UsXAUw==
X-Gm-Gg: AeBDietQlVswiisRuMaU/wgBBoPAjhy8U8Hi+7QzMnQV8LZ2HmBvrJh8qIWO/++dBam
 5tIa3osIjYPcG0+PjqU9kS0FDSiuSMfBMfcnnOabDa0ANsjTo8HKqoj7QqzqLFreMW8gHpTsdYZ
 S0/zgmbb4nHQCxyS2o0i/Gj+QHOpjQICCZiD/hflD+nSCU5xdL+CnDGf8bEmsDKVtpxUOU018v5
 5fCQ2a7YJtf8/WXAIJ9jz22ZtlbyNjJm9KnGdJKP6N5oXCA
X-Received: by 2002:a17:90b:5746:b0:35d:ab26:5786 with SMTP id
 98e67ed59e1d1-3649204bfa1mr5252687a91.19.1777427660365; 
 Tue, 28 Apr 2026 18:54:20 -0700 (PDT)
X-Received: by 2002:a17:90b:5746:b0:35d:ab26:5786 with SMTP id
 98e67ed59e1d1-3649204bfa1mr5252653a91.19.1777427659813; Tue, 28 Apr 2026
 18:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260403185303.80748-1-jonas@kwiboo.se>
 <20260403185303.80748-13-jonas@kwiboo.se>
 <nsgxyv5sflscs66kxcgbyapivu3yjskfqzeqkt4yhnjfomyfav@rkxft2e6lqbd>
 <d9d55427-2f56-4e3b-a476-f3981c9c20a2@kwiboo.se>
In-Reply-To: <d9d55427-2f56-4e3b-a476-f3981c9c20a2@kwiboo.se>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 04:54:08 +0300
X-Gm-Features: AVHnY4IFeksgvOvwzOkQl4tXEKJ57for6VuKl8zutxwbX2nA0ihYBmXwGJG8Yis
Message-ID: <CAO9ioeW+i10LV98AaR3ScT_SsjO73wyd4MRJoK19w_ZKF342Fw@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] drm: bridge: dw_hdmi: Use
 dw_hdmi_connector_status_update()
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: Ydlhd2yArZp9HEmpiByKBqrtoVv8-UfR
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f164cd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8
 a=umLxKfaxry9jw5ZBSt0A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAxNSBTYWx0ZWRfX9C1AIRJ+IXhY
 4NtG0733l2aUXTJppwVakBdk0Va1J+In4Q2gyQkSgoNKatQCjNolMadfhYAjQ3boLpjJEzd9vgS
 +YyrnLSvztTj3PTSaltiZdyHuPptw++i8VUwPCnAMUDilVfbbuU+TKleVTG1tG40pmjfmURUqT7
 vxggR8jz7qlbhb+qqW9MQnyaTYlvut0yzRgo1fdwNo/AdBbKUdJE0PSs12PdpnSSR8fqg7u5LQW
 fSyqmPjVN2azmleDrmM7MdF2TGSc15zQo7RpFlOAXJZivbaPBpCxtU86k4mlZQaFvAlSPAwUSYr
 pExfBgAJeLs+5wf8SLrKd5QQUxqygRVZwDABBSjULnlXYSILQNdZQ8cAWFZ0l/UIZe62G6wzx2s
 w+Io2DgWL+7DQtAyypunOMqLC+Pk+aWz7losp/7fd9IZDNe9qAX8RH7yhz6klxrqGP6WkFjY8ar
 +zJUW8THY3USGG+OQdA==
X-Proofpoint-ORIG-GUID: Ydlhd2yArZp9HEmpiByKBqrtoVv8-UfR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290015
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

On Tue, 28 Apr 2026 at 21:53, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Dmitry,
>
> On 4/28/2026 2:42 PM, Dmitry Baryshkov wrote:
> > On Fri, Apr 03, 2026 at 06:52:58PM +0000, Jonas Karlman wrote:
> >> Update connector EDID and CEC phys addr from detect and force funcs to
> >> ensure that userspace always have access to latest read EDID after a
> >> sink use a HPD low voltage pulse to indicate that EDID has changed.
> >>
> >> With EDID being updated in detect and force funcs, there should no
> >> longer be a need to re-read EDID in get_modes funcs, so drop it.
> >>
> >> This change make the dw-hdmi connector work more closely like the bridge
> >> connector does with a hdmi bridge.
> >
> > Please consider using drm_atomic_helper_connector_hdmi_update()
> > directly.
>
> It is unfortunately not possible to use that helper unless
> connector->hdmi.funcs has been assigned a value, currently something
> that is only done in drmm_connector_hdmi_init().

Ack. Looking forward to reviewing your patches.

>
> As briefly mentioned in the cover letter, I am working on converting
> dw-hdmi to be a hdmi bridge, so this function will be replaced/removed
> in a future series.
>
> See [1] for a work-in-progres snapshot where dw-hdmi use the bridge
> connector and has been converted to a hdmi bridge. This works great on
> Rockchip RK3328, RK3399 and RK3568. More testing and cleanup is needed
> before something beyond the initial HPD, CEC and EDID rework/cleanup
> currently handled in this series is ready for posing to ML.
>
> [1] https://github.com/Kwiboo/linux-rockchip/commits/next-20260427-rk-hdmi-v2/
>
> Regards,
> Jonas
>
> >
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> ---
> >> v3: Reworked 'Update EDID during hotplug processing' patch
> >> ---
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 24 +++++++++++++----------
> >>  1 file changed, 14 insertions(+), 10 deletions(-)
> >>
> >
>


-- 
With best wishes
Dmitry
