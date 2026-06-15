Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3FFCD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE5310E445;
	Mon, 15 Jun 2026 13:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="su42XTgI";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E75910E47D;
 Mon, 15 Jun 2026 13:30:09 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gf9wF0nJRz9v6G;
 Mon, 15 Jun 2026 15:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781530205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Eeo3qNSAbrMgU1daWGabstVi1rfUwgjmPmbJwDBqhA=;
 b=su42XTgInLS6w+P7+6dVJAw+vDxvxfdpI5YqVGtyK8+pCbrAW3tZ3LspomS/dlgAHR+buQ
 3PF3VXMeWoxvTaDC4QFZphSNkVtmrm2lpHkma/yw8Aus3f9OJGBWSXiFBEYKm2AngzFml/
 LLz936YKPJhbibYmS6bd2byNe1Whq2/awrLWAq28clYs/jz1rhTrqb7cgt3EtgtEuKFhNh
 PxqhkuskUmyYsDsduaphfvlWnFgoYwrXKNkQjw495WXAGSHiIUFg5wt2k15LUpp/5uUWUx
 gt/jKL1G29Qa8dtC75LRG783BsgV9rsdaVDMBQism4SsQyUyTaXTrCvRzR49IA==
Message-ID: <7402a175-a1d9-4428-8536-e37f06c1e186@mailbox.org>
Date: Mon, 15 Jun 2026 15:30:00 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] drm/i915: Work harder to enable VRR based refresh
 rate changes on eDP
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org
References: <20260612144203.31715-1-ville.syrjala@linux.intel.com>
 <3d441831-71bc-49fd-823f-3af443e55b20@mailbox.org>
 <31da350f-adfc-4b2c-a7c5-5ed884ffd9ca@mailbox.org>
 <ai_40qUa-MVdbOEf@intel.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <ai_40qUa-MVdbOEf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3ujfq8xumwefn9kq5pz33zjsd6qrsj4d
X-MBO-RS-ID: 127b0e11a3ca2261d62
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

On 6/15/26 15:06, Ville Syrjälä wrote:
> On Mon, Jun 15, 2026 at 11:08:59AM +0200, Michel Dänzer wrote:
>> On 6/15/26 11:06, Michel Dänzer wrote:
>>> On 6/12/26 16:41, Ville Syrjala wrote:
>>>> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
>>>>
>>>> Tweak the eDP fixed mode selection algorithm to allow
>>>> userspace to do refresh rate changes on VRR capable
>>>> eDP panels without full modesets.
>>>>
>>>> Ville Syrjälä (4):
>>>>   drm/modes: Add DRM_MODE_MATCH_TIMINGS_VRR
>>>>   drm/i915: Pass the full atomic state to .compute_config()
>>>>   drm/i915/panel: Adjust intel_panel_compute_config() calling convention
>>>>   drm/i915/panel: Attempt VRR based refresh rate change for
>>>>     !allow_modeset
>>>
>>> What's the motivation for this approach?
>>>
>>> Per https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/5091#note_2784749 , it comes as a bit of a surprise. The approach we've been discussing at display hackfests instead is to add properties for controlling the maximum & minimum refresh rates.
> 
> This has nothing to do with limiting the VRR range. What we're doing
> here is selecting the actual timings to drive an internal laptop panel,
> given some random cooked up modeline from userspace.

This use case would be covered by setting the same values for both properties.

(There are other use cases where changing mode alone isn't enough though, e.g. involving the compositor setting a narrow range between maximum & minimum refresh rate)


> For non-VRR panels we just pick the fixed mode whose refresh rate is closest to the
> user specified mode, and reject the commit if it's not close enough (<= 1 Hz).

Sounds like that wouldn't be good enough for some video use cases I'm afraid.


>>> While the approach in this series could be considered an alternative for the maximum, AFAICT it doesn't allow enforcing a minimum refresh rate which differs from the maximum and default minimum.
> 
> The timings specify the absolute max refresh rate you can achieve. So
> a separate max VRR refresh rate knob would be mostly redundant, but as
> we've discussed before, it could have its uses for the non-integer
> vtotal use cases (CMRR in Intel parlance).

None of that addresses the lack of control of the minimum refresh range.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
