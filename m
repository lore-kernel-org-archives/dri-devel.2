Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABE6C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 19:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 067CB10E42B;
	Fri, 28 Aug 2026 19:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=squebb.ca header.i=@squebb.ca header.b="oy1N6mij";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ox3Ae7/L";
	dkim-atps=neutral
X-Greylist: delayed 403 seconds by postgrey-1.36 at gabe;
 Fri, 28 Aug 2026 19:26:18 UTC
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D99A410E42B;
 Fri, 28 Aug 2026 19:26:18 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B67F11400036;
 Fri, 28 Aug 2026 15:19:34 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
 by phl-compute-02.internal (MEProxy); Fri, 28 Aug 2026 15:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1787944774;
 x=1788031174; bh=8UrWGTVAYCPbHsFpypcrxdz98q19yOUxOWoIeRYoPPg=; b=
 oy1N6mijDar0IP19gbbnP2pqex/L0lk48IGWfq9sGYitAbZqYDUBelLgxTdrIw6x
 yW0kZS5Wi747KSoOi9xl56bb84E6UYBei3qtEivA/QAEldaBUW5B/nVDGviyQFVG
 DtNMEFG+R3pkmnZxlYkTfFtG2hS9YaIg/mOuBOt9G5hyvl1J0EswQ1BYfi1Hf1Ah
 PeWDliX6KdHFmv/V7T7HWVtewOhN61dzX/F3TaMe0v4iLGpDjTqQlz2JUlid1omx
 Ghsmuj8v5yzHPyK8G582Ry0MTnNSAkH2NYSVQmycMyxIOuhuaPsybaQjEGwTM+An
 cdgVp4W37IZNmPknGvL7KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787944774; x=
 1788031174; bh=8UrWGTVAYCPbHsFpypcrxdz98q19yOUxOWoIeRYoPPg=; b=O
 x3Ae7/Lp4V/c/yyErWvgnU7gGpsthtOcqz6LzZWUi2ThMeiWEVn7r1RKXf2AOVH/
 lWLhP++M0d4q4UK6ds/joKGClf4kclAtoHM6wbKgXI6n6JJ8MSMrNEElcMoyye1o
 BeKq1TSE1jEs+owVL+CDyOl4FsOcPe3JSdlesXqu3ebBqjGDrS/R0awrgB5+hR5r
 KDBogeFzDPB4l6MN0FYgqzgjhtHuNS2tVKjtN6Q7tHBF88x2cWTvWWgO1Lfkdw3J
 Wh3QGvvZFeuVE0txSMWQ3O1MaNlKvT9skGBHXY6oA4ri4dasiSIq4Sxpd3YXh76P
 6Du4N7T+u6dnaM9ln6HhA==
X-ME-Sender: <xms:Rt-Rao5hrPXJ6hvua06iEkf6KrPhCodnaMFvOcOjMHeIi9MaF8bGbw>
 <xme:Rt-RakvxgWjyeL7JbC7IYlYmMLe-09mzPHMqa_GzGyjmgF0yKmPhe0y4MZQepdNXo
 8eFj2WckGPLFqf-ovh5KCtqixsDNdUSFeUOxSiRyC0qhM-vxs0uROc>
X-ME-Proxy-Cause: dmFkZTGUliR0QyWBaMTSf5t4yQCBmBNl0fitsyVb6bxaqJD+aPUq/dkwZ93sRqftcQX/qQ
 aEdRxIfnWayxm6V7AbnJj3HUma/2MGhY8fAJSI9Me7kmz1LUqQWmo9K4FdIcqwUvvVmXSf
 S7iY5soVIGa4I20+jmzS3g35XQ6k+NaNg4IhTSarFBMIw9o858+XmSBe1Hi3kKR2L6NWh6
 HExgG+Wuwqul4PQATWz0hQfg3cnD2SZ6FVLfdz6JoqZxwl3IAGzcE3adSGLWpcu2o/4B/+
 RNS4VInzCGx9bDCrsDTZF8/Mx+s0Wm2pUpOTygksjVn7eTgztdO1c199bLYSmb8s5TjLgZ
 MJiTFUhNMT66lEBQ5vgjtYmvk8E8OuB0EzDWYmSFet5vXT3UqqTdZn+KMWaHNlsaqBsJKa
 tIGogVWokg9DBBFn03Dryd6P9ETXUD3kAcy0O9WsIXMCbqP3VQCkMIpF21Auw+FiYvht90
 do6/1WlNquF+2ECc8/6o1fT+kL2cmYE3QGXlDJAk3W+Tkzvs/LLkehx5O/qPoSsfY85Nq3
 9dbyZoxS61M4kzB/crzf8FRXzkhyPLkNZ2uolWgw7ZpofKYUjjxdUzM7w2Ojic3dfrwHzt
 UGMYuZBTNgu6wY8cqMNCeOJHgDhoL+fi286GJ9avnE+qgQBe3VR8a40HVutw
X-ME-Proxy: <xmx:Rt-RaieAvDaRHhoRkKAn1Q5bjaEhXAiezGP2zv06NFoEgZa4_Hd23g>
 <xmx:Rt-RaoFtPpZQJhK0DfyL4Uudsok5Gh-Yw3eTFg4OMA067uInXZXBaw>
 <xmx:Rt-Ragihra9rSuXZKTK-_-_sCdrJk1gDzScYv7LvQUPgFWVxJjEBfg>
 <xmx:Rt-Rak0rLOwTVLH2IKYPjghXmlgjWPMVwJJy-NsiJsS9EWCybvTTBQ>
 <xmx:Rt-RatWkFIQWLLYdvvMOssSuhegLfa7n6V96m--pnqSyePo0VhSPqp29>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 4A7953020086; Fri, 28 Aug 2026 15:19:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AFiiAAqIAeUF
Date: Fri, 28 Aug 2026 15:19:14 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Narek Sarkissian" <narek@sarx-technology.com>,
 "Mario Limonciello" <superm1@kernel.org>
Cc: "Alex Hung" <alex.hung@amd.com>,
 "Alexander Deucher" <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, kernel-dev@igalia.com,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Melissa Wen" <mwen@igalia.com>, sunpeng.li@amd.com
Message-Id: <47be5869-69c3-4066-bcc2-738b838219fc@app.fastmail.com>
In-Reply-To: <20260828190727.58724-1-narek@sarx-technology.com>
References: <fc3f474b-92bd-46b3-919a-dec8ea105b86@kernel.org>
 <20260828190727.58724-1-narek@sarx-technology.com>
Subject: Re: [PATCH v8 5/5] drm/amd/display: Fetch the EDID from _DDC if
 available for eDP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Hi Narek

On Fri, Aug 28, 2026, at 3:07 PM, Narek Sarkissian wrote:
> Hi Mario, Alex, Alexander,
>
> Following up on this patch (c6a837088bed) with a regression report on a
> different Lenovo model.
>
> On a ThinkPad T14s Gen 3 (AMD Radeon 680M / Rembrandt, DCN 3.1.2), this
> change causes the internal eDP panel to be capped at 60Hz even though
> the panel natively supports 90Hz. dm_helpers_read_local_edid() finds
> an ACPI-provided EDID via _DDC and uses it unconditionally, but on
> this machine that ACPI blob is a stale/incomplete copy of the panel's
> real EDID: it encodes only a 60Hz detailed timing, while a live DP AUX
> read of the same panel (Samsung Display, ATNA40YK08-0) returns 90Hz as
> the native/preferred timing plus 60Hz as a secondary mode. Both DTDs
> share the same pixel clock and htotal, so the ACPI copy looks like it
> was deliberately downclocked rather than being a different display.
>
> dmesg confirms the code path taken:
>
>   amdgpu 0000:33:00.0: [drm] Using ACPI provided EDID for eDP-1
>
> Booting with amdgpu.dcdebugmask=0x8000 (DC_DISABLE_ACPI_EDID) skips
> the ACPI EDID and forces the live AUX read, which correctly exposes
> 90Hz and reports the panel's real vendor (Samsung) instead of Lenovo's
> ACPI-authored EDID (manufacturer/model LEN 16713).
>
> Full writeup with the EDID diff (byte-level comparison of the ACPI
> blob vs. the live-read panel EDID), environment details, and repro
> steps is here:
>
>   https://gitlab.freedesktop.org/drm/amd/-/work_items/5710
>
> Since this same unconditional ACPI-EDID preference apparently fixes
> T14 Gen 4 but regresses T14s Gen 3, an unconditional preference in
> either direction doesn't seem to work for all eDP panels globally.
> Possible directions raised in the issue: fall back to ACPI only when
> the live AUX read fails (inverting current priority), prefer whichever
> source has more/higher-refresh timings, or gate the ACPI-EDID
> preference behind a DMI-based quirk table scoped to the models that
> actually need it.
>
I think this is working as designed.

I'll try to find our internal ticket with the details (my memory is a bit rusty and this is a few years old now), but as I recall they saw issues with Windows testing with 90Hz and so limited the panel to 60Hz - using the BIOS EDID to do this. Linux is just following the 'manufacturer recommendation'.

If you're not seeing issues, then overriding it to use the panel EDID is fine, but just be aware that the 90Hz did not pass Lenovo QA.

Mark
