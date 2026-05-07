Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BEFCD3447
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 16:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A5C10E59A;
	Thu,  7 May 2026 16:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GrWRAy91";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 118B610E2A7;
 Thu,  7 May 2026 16:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Content-Type:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dL/Cdj70a+69RDawvzXxspykwjNRMwleKvjJH59GSgY=; b=GrWRAy91TakeCfhYNYFXFYADxz
 z86ckN/CCswbutFrbySDyC/sG1DCj7LI4bZHTNXNZ1RzGyT2KPSewfvi6Lg4TwF0nSKTjG3LM7A3A
 6t/6uEVRwzk/hRoX3XU/XFoNHDcnqDcNbk5+s94jC4FyV9Vf4AzkInYYTVaRBMy4Xt+eL73uR+3/j
 dW4FtD1lIswqXxAqhC2bFpD5R62fB+VTcbMW2Tl7qZVearEPFOp407ymKe5lWv1eSXiqAzF0eww1C
 wEwYoH7hYwaL8joP/54WJutfHX+SgALvnntn4q0v4KOVzYfUhb0s+OvxcpxxwTgUeyi2XTBvaSouf
 dzelp+CQ==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wL1NG-007Tof-7N; Thu, 07 May 2026 18:14:53 +0200
Content-Type: multipart/alternative;
 boundary="------------0kipZKtZbyND9PGbNQ31AJu7"
Message-ID: <3cf6f786-6ef4-4ab5-9c68-fe34e6066913@Igalia.com>
Date: Thu, 7 May 2026 09:14:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] drm/msm/dpu: don't mix devm and drmm functions
To: rob.clark@oss.qualcomm.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, kernel-dev@igalia.com
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <20260505-wb-drop-encoder-v5-1-42567b7c7af2@oss.qualcomm.com>
 <CACSVV00TsXn=yx2UeGpxvCWRkSdj0=_=3_s01wCaO1RDH8t_vA@mail.gmail.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <CACSVV00TsXn=yx2UeGpxvCWRkSdj0=_=3_s01wCaO1RDH8t_vA@mail.gmail.com>
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

This is a multi-part message in MIME format.
--------------0kipZKtZbyND9PGbNQ31AJu7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/5/26 14:49, Rob Clark wrote:
> On Mon, May 4, 2026 at 5:25 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>> Mixing devm and drmm functions will result in a use-after-free on msm
>> driver teardown if userspace keeps a reference on the drm device:
>> The WB connector data will be destroyed because of the use of
>> devm_kzalloc()), while the usersoace still can try interacting with the
>> WB connector (which uses drmm_ functions).
>>
>> Change dpu_writeback_init() to use drmm_.
>  From [1] it doesn't sound like userspace holding the drm device open
> is the issue (if that were possible, it seems like it would go badly),
> but rather the order of managed cleanup?
>
> [1]https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/xe/xe_hwmon.c?id=3a13c2de442d6bfaef9c102cd1092e6cae22b753
So is this not an actual issue that has been seen in the wild? It is 
just a theoretical issue based on code observation?

If so, then maybe the comment should just be something like:

    dpu_writeback_init() was mixing devm and drmm functions - allocating
    using devm and then passing to drmm to manage. This creates the
    potential for a use-after-free bug as drmm and devm have different
    lifetimes. Fix that by consistently using drmm management.


John.


>
>> Fixes: 0b37ac63fc9d ("drm/msm/dpu: use drmm_writeback_connector_init()")
>> Reported-by: Christophe JAILLET<christophe.jaillet@wanadoo.fr>
>> Closes:https://lore.kernel.org/r/78c764b8-44cf-4db5-88e7-807a85954518@wanadoo.fr
>> Signed-off-by: Dmitry Baryshkov<dmitry.baryshkov@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
>> index 7545c0293efb..6f2370c9dd98 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
>> @@ -5,6 +5,7 @@
>>
>>   #include <drm/drm_edid.h>
>>   #include <drm/drm_framebuffer.h>
>> +#include <drm/drm_managed.h>
>>
>>   #include "dpu_writeback.h"
>>
>> @@ -125,7 +126,7 @@ int dpu_writeback_init(struct drm_device *dev, struct drm_encoder *enc,
>>          struct dpu_wb_connector *dpu_wb_conn;
>>          int rc = 0;
>>
>> -       dpu_wb_conn = devm_kzalloc(dev->dev, sizeof(*dpu_wb_conn), GFP_KERNEL);
>> +       dpu_wb_conn = drmm_kzalloc(dev, sizeof(*dpu_wb_conn), GFP_KERNEL);
>>          if (!dpu_wb_conn)
>>                  return -ENOMEM;
>>
>>
>> --
>> 2.47.3
>>

--------------0kipZKtZbyND9PGbNQ31AJu7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 5/5/26 14:49, Rob Clark wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CACSVV00TsXn=yx2UeGpxvCWRkSdj0=_=3_s01wCaO1RDH8t_vA@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Mon, May 4, 2026 at 5:25 PM Dmitry Baryshkov
<a class="moz-txt-link-rfc2396E" href="mailto:dmitry.baryshkov@oss.qualcomm.com">&lt;dmitry.baryshkov@oss.qualcomm.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Mixing devm and drmm functions will result in a use-after-free on msm
driver teardown if userspace keeps a reference on the drm device:
The WB connector data will be destroyed because of the use of
devm_kzalloc()), while the usersoace still can try interacting with the
WB connector (which uses drmm_ functions).

Change dpu_writeback_init() to use drmm_.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
From [1] it doesn't sound like userspace holding the drm device open
is the issue (if that were possible, it seems like it would go badly),
but rather the order of managed cleanup?

[1] <a class="moz-txt-link-freetext" href="https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/xe/xe_hwmon.c?id=3a13c2de442d6bfaef9c102cd1092e6cae22b753">https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/xe/xe_hwmon.c?id=3a13c2de442d6bfaef9c102cd1092e6cae22b753</a></pre>
    </blockquote>
    So is this not an actual issue that has been seen in the wild? It is
    just a theoretical issue based on code observation?<br>
    <br>
    If so, then maybe the comment should just be something like:<br>
    <blockquote>dpu_writeback_init() was mixing devm and drmm functions
      - allocating using devm and then passing to drmm to manage. This
      creates the potential for a use-after-free bug as drmm and devm
      have different lifetimes. Fix that by consistently using drmm
      management.</blockquote>
    <br>
    John.<br>
    <br>
    <br>
    <blockquote type="cite"
cite="mid:CACSVV00TsXn=yx2UeGpxvCWRkSdj0=_=3_s01wCaO1RDH8t_vA@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Fixes: 0b37ac63fc9d ("drm/msm/dpu: use drmm_writeback_connector_init()")
Reported-by: Christophe JAILLET <a class="moz-txt-link-rfc2396E" href="mailto:christophe.jaillet@wanadoo.fr">&lt;christophe.jaillet@wanadoo.fr&gt;</a>
Closes: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/r/78c764b8-44cf-4db5-88e7-807a85954518@wanadoo.fr">https://lore.kernel.org/r/78c764b8-44cf-4db5-88e7-807a85954518@wanadoo.fr</a>
Signed-off-by: Dmitry Baryshkov <a class="moz-txt-link-rfc2396E" href="mailto:dmitry.baryshkov@oss.qualcomm.com">&lt;dmitry.baryshkov@oss.qualcomm.com&gt;</a>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index 7545c0293efb..6f2370c9dd98 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -5,6 +5,7 @@

 #include &lt;drm/drm_edid.h&gt;
 #include &lt;drm/drm_framebuffer.h&gt;
+#include &lt;drm/drm_managed.h&gt;

 #include "dpu_writeback.h"

@@ -125,7 +126,7 @@ int dpu_writeback_init(struct drm_device *dev, struct drm_encoder *enc,
        struct dpu_wb_connector *dpu_wb_conn;
        int rc = 0;

-       dpu_wb_conn = devm_kzalloc(dev-&gt;dev, sizeof(*dpu_wb_conn), GFP_KERNEL);
+       dpu_wb_conn = drmm_kzalloc(dev, sizeof(*dpu_wb_conn), GFP_KERNEL);
        if (!dpu_wb_conn)
                return -ENOMEM;


--
2.47.3

</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------0kipZKtZbyND9PGbNQ31AJu7--
