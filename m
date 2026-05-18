Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52534CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 08:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AECB410E2EC;
	Mon, 18 May 2026 08:31:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="kRAvN0Yb";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0677510E2EC;
 Mon, 18 May 2026 08:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779093056; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=O/aIMUqkdKkeEx0zk4w+/gTWtFJSxw0gtg+YxcUCUk/q1AWeipZBADuXhISdcuaV2QV8DpV11dt/fXpvO7ph1OjWTFdlLTvJKUTIGKSu6Z4ZFZnqfuA9HbfoAFKpg7wTi+yCZbzaJJtJZroCsydV7RAd4bidchhNMm+vMkushno=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779093056;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7cvFg1v6Byd03Aua4VwmWppdLJjh9Pv/pPTw0kVcuAI=; 
 b=ErkXDiLhdHj7+pC+fGq5qbhG69m6yyzpep+MuZmr3USfvHXp4lRt42UkxZPngSRVb7S+0LKvRm2eWofycES2wy2qW/QOyUwlnj563L9uzy5ma4+K5HcqkxSmQ28A0PbZak3S+9/QHxxHSBinQAncO0mWhJOC9elAEJQ/dVQhQQ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779093056; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=7cvFg1v6Byd03Aua4VwmWppdLJjh9Pv/pPTw0kVcuAI=;
 b=kRAvN0Ybkr2TLuxXteTwDUNx3e3jIYHWDqmlCUXtSRYzB5zKDtN904KWygba+NyH
 2Ak2sf5PvDj16U7z3bO7883kX2cQZQ4cKX5zg1sC5D7lpIPA5LuGWhPNMjSonRKf+u7
 9FitD18bneyRP4ql/h6Az4GBoLhVVw59NS2ttH4g=
Received: by mx.zohomail.com with SMTPS id 1779093053865286.84345520213753;
 Mon, 18 May 2026 01:30:53 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: TR Reardon <thomas_reardon@hotmail.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v14 03/28] drm: Add "color format" connector property
Date: Mon, 18 May 2026 10:30:50 +0200
Message-ID: <dC5QK-GpRfulUfZm8cVlCQ@collabora.com>
In-Reply-To: <SA3PR22MB4082A5AEA36B5FAD0CAC7125FD042@SA3PR22MB4082.namprd22.prod.outlook.com>
References: <SA3PR22MB4082A5AEA36B5FAD0CAC7125FD042@SA3PR22MB4082.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

Your message lacks a In-reply-to header, so it broke the thread. You also
removed everyone else from Cc, including all lists other than dri-devel.

On Saturday, 16 May 2026 02:17:37 Central European Summer Time TR Reardon wrote:
> Hi Nicolas,
> 
> Apologies for surfacing this on v14 - the feedback is overdue and I should have raised it months ago.
> I am writing from the perspective of a developer of media player software for Linux.
> 
> In the kerneldoc the patch adds for DRM_CONNECTOR_COLOR_FORMAT_RGB444:
> 
>    The quantization range depends on the value of the "Broadcast RGB"
>    property if it is present on the connector.
> 
> I want to raise a related problem that I think is in scope to solve as part of this series: limited-range RGB (e.g. 16-235 out of
> 0-255) is broken in the DRM pipeline.

That does not appear to be in-scope for this series. This series is about
allowing userspace to choose RGB vs YUV and the YUV subsampling to use.
As a point of comparison, the color format property also says nothing
about the wire's bit depth, even though this is something that userspace
may want to control; there's a separate property for it.

The reason why chroma subsampling + RGB vs. YUV is in the same property
here is that subsampled RGB wouldn't make sense, and the two things also
aren't talked about separately in any of the display protocols from what
I can tell. I believe this is part of why it seems attractive to tack more
bits of the output parameter space onto this property, even though an
additional property could communicate that as well.

> 
> 'Broadcast RGB' couples three semantically independent things into a single enum:
> 
>   1. How the framebuffer is encoded (full 0-255 or limited 16-235)
>   2. Whether the encoder-side pipe applies the 219/255 + 16/255 CSC compression
>   3. What the AVI Q bit (HDMI) or equivalent MSA signal (DP) declares to the sink
> 
> The three supported values bake assumptions about all three:
> 
>   Full       FB is 0-255, no pipe CSC, signals FULL
>   Limited    FB is 0-255, pipe compresses to 16-235, signals LIMITED
>   Automatic  Per CEA-861-E section 5.1: CE-mode VICs behave as Limited,
>              IT modes as Full
> 
> None expresses what userspace actually needs when it has produced limited-range content itself: "leave my pixels alone, signal
> LIMITED on the wire." The CTM property is not an escape hatch either: the limited-range CSC has a fixed +16/255 postoff that no
> symmetric 3x3 CTM can cancel.

I'm not sure if "leave my pixels alone" would be a good design for
the uAPI; I think it's much better to tell the kernel *what* your
pixels are so that it can leave them alone when it doesn't need to
touch them. Specifically, the case you're talking about appears to
be that the kernel does not realise that the contents you're submitting
from userspace is already limited range, so it would go through
double-conversion if "Broadcast RGB" was set.

> I want to emphasize: this means Linux is incapable of sending SMPTE-standard RGB over HDMI or DP. The content is either corrupted
> by the kernel's compression stage or the wire signaling is wrong - do one or the other, not both. This is a long-standing gap
> that I am hoping can be addressed in scope of this series.
> 
> Proposal: rather than touching 'Broadcast RGB' (which keeps its current behavior unchanged), add a new value to the color format
> enum that explicitly declares limited-range RGB content on the wire:
> 
>   DRM_CONNECTOR_COLOR_FORMAT_AUTO
>   DRM_CONNECTOR_COLOR_FORMAT_RGB444          (existing - full 0-255, current semantics)
>   DRM_CONNECTOR_COLOR_FORMAT_RGB444_LIMITED  (new - declares 16-235 RGB on the wire)
>   DRM_CONNECTOR_COLOR_FORMAT_YCBCR444
>   DRM_CONNECTOR_COLOR_FORMAT_YCBCR422
>   DRM_CONNECTOR_COLOR_FORMAT_YCBCR420
> 
> Semantics of the new value:
> 
> - It is purely a wire-side declaration: the AVI Q bit is signaled as LIMITED, and the kernel makes no other change to the
> pipeline.
> - It does NOT alter what 'Broadcast RGB' does. The pipe-side CSC behavior remains controlled by 'Broadcast RGB' exactly as today.
> - Userspace that wants pass-through limited-range RGB on the wire sets 'Broadcast RGB' = Full (so the kernel does no in-pipe range
> conversion) AND color format = RGB444_LIMITED (so the wire signals LIMITED). The two properties are orthogonal.
> - Userspace that wants the legacy "kernel compresses and signals" path continues to use 'Broadcast RGB' = Limited and leaves color
> format at AUTO or RGB444.
> - If both 'Broadcast RGB' and 'color format' would request LIMITED for the Q bit, that is just redundant agreement, not a conflict.

There is nothing in this proposal that couldn't be added later,
if you wanted to do this. I don't agree with the concept of making
the color format encode more than what it currently encodes.

I do think the better solution for this issue is to extend the
Broadcast RGB property for your purposes, e.g. have a "Limited
Passthrough" enum value for Broadcast RGB that tells the kernel
to assume the input is already limited range. Alternatively, add
a new property that describes what range the input is, and the
kernel can then choose to not convert on the basis of that.

> This preserves the existing design assumption that bare RGB means 0-255 full range and that 'Broadcast RGB' is the knob for
> kernel-side range conversion. The new value adds an explicit way to declare limited-range content on the wire without taking on
> the in-pipe CSC as a side effect. Userspace that produces limited-range RGB itself - either because that is what its content
> already is, or because it wants to take responsibility for its own pixel encoding - now has a lossless way to express that intent.
> 
> Thanks,
> 
> 
> +Reardon

I won't work on fixing the issue you brought up here, but you can send
your own follow-up series once color format has been merged to extend it
in this way. I suspect however that maintainers won't be fond of this
approach. I believe extending Broadcast RGB for your purposes may be
the better option, though I didn't look into how the colorspace property
would interact with this as well.

Kind regards,
Nicolas Frattaroli


