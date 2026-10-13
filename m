Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B410CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC0410E22F;
	Tue, 13 Oct 2026 11:57:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA2510F7B5
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:57:35 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D9uPxs3475960
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=tzZokV4UDOIHODHJyTn32egA
 FPE75bJMpUh7wLNQ3Sw=; b=ALZ7XHVGdqgJAdRs3FEVk0H90aYVKF4mPQYBSP2/
 /NOXb4QkHzh/vCS0gefaO2JrwvUhzHtJ7A/LfQ9c5QJqhikU9sGmGAxsTLpd+y7w
 HBZoMEIhzxKVHnnfx+GHnQiJlUttfX4SWhhyiL/m6C/t9ntZlP2g8n4qjDX7GxfP
 SH4eShtmRFqMRG8CzFDh7Ar3DKNZfQZheSHRWWJLWLDaEXDf5PqQXnPUvT/mXfI7
 EWxsa/u6vEo6lmMjq3N+lW5/d2TD9TVJoo5Nk47brUxAphdEG8+i+pBAs1cpAQ+f
 6mtebk9hL3s8gJJUMFtw6h5+uIgQX4oVi3+FhQaap3+cJA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9d7j9w0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:57:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a082c014aso637116885a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791892654; x=1792497454;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tzZokV4UDOIHODHJyTn32egAFPE75bJMpUh7wLNQ3Sw=;
 b=GPJD008OwHxMzFDapeVQ1Ed2zYxM+TnH12Eofy4rPHYJnNZamocqoFLcQjFisB2FWH
 WC/0bUmqYQC05Y4AdD6RUkYbdXnsdiCm4HdOKxnt+V0CmMqsgHkxS/o0+geDvd7LTh4n
 64wg1oRI38xmZhXLU+oJTfpMxnr6ygmxDTYN+yYRoXvPA3vy15Ha1ZABTl6EURq162a9
 OxbrHc4f8ev1UkgafUoNJ+K9od0yXM44T6xt3NVa48lbCUZx/vkVKoBR6fayOSRZZ/12
 zU9up+UMbQi/RRXMkxrSFX0a6pxtn25wYkMSP1RS4JGooMS2kg1jqVn45Bwkri7eP+aT
 mkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892654; x=1792497454;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tzZokV4UDOIHODHJyTn32egAFPE75bJMpUh7wLNQ3Sw=;
 b=ZGOTE4FD4tbperVKsOdUvQ2tMlzqKNAp/q/+vbWOvhFiqymBNbrzaxsyB7ReOwRPHK
 zJ6a6Mw42hXWQsLUUg58ZSmwiM97v1t2SSBpn/J5unr5UqXpgm29E00mVRVFrXMqVrum
 a1ccvS6D0R9SvX3ywNqILoppuOClUVMPqsb3FXLObNrr9RR8diy8Qy10QP10ToADiBCR
 XO19gDU4VTHF2rmLZtMl3R1eXKCxxYqdEcljhqCioT4uiz+EnD5EH1TPXp3mHmYCRq2T
 Ke7uICjW+YWKAytBpIEt2z3HjGWZXlvER+PuiybO+m7VJXrgPRyjyDtT+2pgvvfIGogT
 Ehjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxh0QEB1N0/ooDnGVjyIFzoPMtPtP5dvbkPz24eMXn4/XiSoH0C4g2nGDwvrq0Tz8hI/z/5sSAYXFo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLTUxr+w+5yXr/Cjk3Pqp124onHaUbHbfRMt0ZosPiYVWV0jED6
 qK5YofnC5cXnZaV8KfSRmkwgBS3yYucsmZ5pfvRJqvl4wI7C+1fLiyGcC9OxpjnLE2HndTpyz8a
 GYfbCLrl4SNGbew822ATSANzznWFiteW60R+UfkSHQ50AwVduHTAGiF460OqXzcnzNS+Vxfg=
X-Gm-Gg: AYBFou0bruD4Hg/yTr2+gKt8jdj4MSWEZoo687wLra1CoskP40lOE6r50yYHekIDsBN
 E8ApAiGeMRpUlPl6HetwvIjoAT98el9r+KRiLJuQStKBqWnOIpkQkkUnCrCeSPbJ6O028t9gfQq
 BN1WDJJCQA6doHLFaAI7i5qDqfAhI6UYsMRfCPFB8sC1TaVRVN2zuOshe0i1mr7oioYdpPY9sbg
 JzVltuxJddjCZ9M7g0G2TrIYkQTakouSB3U24kjBEHO9qozHOZ0/8fbTxxZi+Fc1F7ZA8BAzPJI
 SqrnnkBYQiiyd4Tz5eRe2UUCZ9PftyofkX4uAOAaqru6pzzS0WlFtbClpvqe9ySc7rUu/+pWq61
 AhbzAd4V2DRfb+nWNDP32MOCi6ZeVcjcXEWcj5dcq127tX0NqoTmr5Y8HcDA+mYed1LS44SwRFl
 wgAGCRKX1pYaVE
X-Received: by 2002:a05:620a:1a03:b0:93c:6e1d:96b0 with SMTP id
 af79cd13be357-93eb96174d8mr2042570385a.17.1791892654166; 
 Tue, 13 Oct 2026 04:57:34 -0700 (PDT)
X-Received: by 2002:a05:620a:1a03:b0:93c:6e1d:96b0 with SMTP id
 af79cd13be357-93eb96174d8mr2042566785a.17.1791892653560; 
 Tue, 13 Oct 2026 04:57:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9e4c55247sm14672161fa.17.2026.10.13.04.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:57:32 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:57:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Val Packett <val@packett.cool>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/9] drm/panel: add atomic state
Message-ID: <lm7u5tcnccbtbxqeyyqzzvmmhpy2dfhgnyz3giqtt5toejy7pj@7bwixidtqxfz>
References: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
 <asyAObcpbFy3OeE2@houat>
 <7pptulwzceqg7xozps5boncgcpd5fpw2pdabcslp4den34ixjn@rzgkoe36itwm>
 <as3sI-N3VeG_pL0U@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as3sI-N3VeG_pL0U@houat>
X-Proofpoint-GUID: 8L_1EL54myW64dw_Oa523PuNMynBFnsQ
X-Proofpoint-ORIG-GUID: 8L_1EL54myW64dw_Oa523PuNMynBFnsQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0NyBTYWx0ZWRfXzKZFGCpO+AvA
 wEpUPoDZG6POrtOumKT+X2sdLuX9Es+pbojTxa4P0M2kbsTaKQLjVlVeWRstyMFzt9TQJgj/d18
 wLeGQxGcDkpqCf27pBSgiicDLxXm7AY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0NyBTYWx0ZWRfXz47e9kGmCfE7
 8B2ODnGp8+nukXDIkjDFWiIdj14h3OaofbUvdNW1jzGliUijJRLjaQNgTYfY0NRQ/00H+HCJ8L5
 36LrWxVwx3Q75ZYaZ3HqB8lse1NUb3nDr2C1FnqDzqpjHt83CpyJ+9DuobdyAwprikkqxirODDi
 59t0YYduq51y55N+hkpsi7673VWoaPE4DQHnECiBDOBqQzSkFYGiHm04xq00SNPtOldF4JuMNFn
 X5xYHoqcm3uafivgw7Cqq02DWwnmtPjFxb4EEU4qjVRrGyxkQmKnQL+4MRXaZ+Aj0KVrRWOtg5q
 VekjZYQzE3Ni6gK9aTx5mUpL818+ivuYlfqLni8/0zc5bPzXRrzxDiYia7h1DeVmbiuL5mivnIo
 p/9gbC7CWJftHFYoDLoPpsLSsnodJLUt4Qzh0/W6oFPqexCy+B7/VYCtMBSPB/qCWVDWJgk8D5l
 lFTUSZp8yn1jXe0kLtA==
X-Authority-Analysis: v=2.4 cv=PMGaavqC c=1 sm=1 tr=0 ts=6ace1caf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=iLRE3vLiE8gXMxKRWqAA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130047
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

On Tue, Oct 13, 2026 at 10:37:19AM +0200, Maxime Ripard wrote:
> On Tue, Oct 13, 2026 at 10:51:38AM +0300, Dmitry Baryshkov wrote:
> > On Mon, Oct 12, 2026 at 08:40:33AM +0200, Maxime Ripard wrote:
> > > On Thu, Oct 08, 2026 at 04:14:22PM +0300, Dmitry Baryshkov wrote:
> > > > Panel drivers don't have an atomic state and so they can't handle
> > > > additional data to be stored at the atomic_check time or to be retrieved
> > > > at the enable/disable time. For example, it prevents panel drivers from
> > > > supporting multiple display modes or making DSC being optional in a
> > > > clean way. Drivers like panel-novatek-nt35950, save the connector
> > > > pointer in get_modes() and later dereference
> > > > connector->state->crtc->state from prepare() without holding any locks.
> > > > The panels also have no way to reject the configuration they cann't
> > > > handle, as it doesn't take part in the atomic check.
> > > > 
> > > > The panel already embeds a drm_bridge, and the bridge has an atomic
> > > > state which is property handled. Subclass it to provide atomic state for
> > > > the panels. The callbacks can find the state of the other related
> > > > objects (e.g. CRTC state to get the display mode).
> > > > 
> > > > The atomic state is opt-in. A panel that doesn't implement the state
> > > > callbacks keeps working exactly as before, with the plain bridge state,
> > > > so there is no need to touch the existing drivers. The panels which do
> > > > implement them can only be driven through the embedded bridge, since
> > > > there is no commit to hand over when the host calls drm_panel_prepare()
> > > > and friends directly. Those entry points warn and refuse to handle such
> > > > panels. There are still a dozen of display drivers calling these
> > > > functions, and the panels used with them can not be converted until the
> > > > hosts are switched to the panel bridge.
> > > 
> > > I really don't think we should extend the panel API. All panels are
> > > bridges now, consumers only care about bridges as well, and the bridges
> > > API provides what you want already.
> > > 
> > > Why not simply turn the panel drivers we want into bridges, possibly
> > > with a bunch of specialized helpers to manage a panel state, and call it
> > > a day?
> > 
> > I think that panels provide good abstraction on top of the drm_bridge.
> > For example, bridges don't have orientation, panels do.
> 
> That's easy to add.

What would it mean for the bridge? I was thinking about pulling
orientation from the per-panel code to a generic code path, including
reading and handling it. I'm not sure if it should be done in the
drm_bridge code if we declare drm_panel deprecated.

> > Also panels have followers, while bridges do not.
> 
> Ditto
> 
> > I don't think that either of those APIs make sense for bridge.
> 
> Why not? In a world where we have bridge hotplug for example, it would
> make total sense to me to have bridge followers. I think Luca even had
> that at some point in his series (and still might?).
> 
> > Last, but not least, we have drivers that were not converted to the
> > bridged approach (*).
> 
> I'm not disputing that, but it's a matter of months at this point, Luca
> already did a significant part of it.

Sure.

> > As such I think we should evolve the drm_panel, extending it to
> > support atomic state.
> 
> I still think that drm_panel is on the way out with bridges taking over
> for years now, and we should accept it. Otherwise we'll just end up with
> two concepts with the same purpose which isn't great.

Ack. Let me check if I can get rid of drm_panel_funcs easily, because
then we can start using atomic ops for the panels, while phasing out the
drm_panel abstraction.

-- 
With best wishes
Dmitry
