Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40314CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90B8410F4BE;
	Tue,  2 Jun 2026 18:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="1EsGUFpV";
	dkim-atps=neutral
X-Greylist: delayed 498 seconds by postgrey-1.36 at gabe;
 Tue, 02 Jun 2026 18:41:23 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5645410F4BD;
 Tue,  2 Jun 2026 18:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oldschoolsolutions.biz; s=s1-ionos; t=1780425681; x=1781030481;
 i=jens.glathe@oldschoolsolutions.biz;
 bh=s2g27FFj4SyeGT+RQPpmlU62O+1qoErhbW7atINmYwo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=1EsGUFpVnnsE5B0oXf8nbo29wgc0rUQh386deL4aDO/4DDp1yw8I3RrnHA5W/f6J
 U6vbSe2c3K6VtH/64/sXbOnS4qj3nAOQGEF4A4GHwRFyUy3O7UGiQj9CVQZMaJTX7
 LOcRwPi/pHriCovRPZOXUf5i/2klzarDqZwgW62Gcj4x1Qp1t3XrkEUlCAtHaXr+k
 o11SBq5Rjw+HNiFOS1zpJwcyrN8AhObuy2Uvgv6G1Jq6sUeqdJWFkKSI7mYrQOKsz
 RnSGSy3iDoDDt6gcWP3yoSeRxJ8jX3qAYFpoftfO0sAFIjfrvCQrhJ0tk0gRCGFfH
 TEVRDAlft1eSebcG5w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N33AR-1xQggY1yvt-00slrF; Tue, 02
 Jun 2026 20:26:35 +0200
Message-ID: <240b394b-46c5-4d9b-85fa-981e2c3b9457@oldschoolsolutions.biz>
Date: Tue, 2 Jun 2026 20:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] drm/msm/dp: add EDID re-read retry in
 msm_dp_panel_get_modes()
To: Jani Nikula <jani.nikula@linux.intel.com>, Jens Glathe via B4 Relay
 <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260531-drm_plug_flaky_edid-v1-1-2708c16dce97@oldschoolsolutions.biz>
 <d50293fab9e6292220b1817a8e85bbd89743b708@intel.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <d50293fab9e6292220b1817a8e85bbd89743b708@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ESetc5kZkGB0y4ImqTCqke0Rum4vzm47lKLJRUXoDQl/vZrSps+
 OLtheZoqtvb3BowbhFGRufRKZxZzWgGUCIdlkk14i+K8REH8vHureNMLFZFO1IbAPpzacgD
 RphZk/KIaD1/8m22ejZ20YSIYCcmQNIIcv7BqIveGZvQTEIf89NpZ55rvSH1h3dPtXVBmR6
 7R1eZkVsGN9v+eDXp8mEg==
UI-OutboundReport: notjunk:1;M01:P0:884Tpz7bEDA=;kCZ7E3xJNgvXSx1V/NCEU+U4epc
 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
 S49VijT36Cq3z+VxBvcEeVZPO9kN0=
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

On 01.06.26 12:57, Jani Nikula wrote:
> Did you actually bisect to this commit? It's a bit of a surprise.
Hi Jani,

haha yes, sort of. I did a few weeks of bisecting for a different issue=20
[1] and this error message came up increasingly, so after resolving (or=20
so) the first one I took a shot at it. The commit was the result of git=20
blame for the line that the retry was programmed around. And as v2=20
shows, it was the right intuition.

[1]:=20
https://lore.kernel.org/all/20260530-typc-mux-modeset-v1-1-64b0281e2cd6@ol=
dschoolsolutions.biz/

with best regards

Jens

