Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5A91075269
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE3310EAB9;
	Fri, 20 Mar 2026 12:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Li8/pXHT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE2810EAB9;
 Fri, 20 Mar 2026 12:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kEnWwn4hCL/bKIi4frW8u1y9gr96rd7KnbMzf+7KM8Y=; b=Li8/pXHTzlSfU5VAjZY5WKsJtk
 lCzyyKlgOTd7ykcZTq9lMLJ6cC4I4Qxqiuvbrt+6jcZmkvVyuiOzipFt3qH4tr3LPw6kAu0nWgd5V
 /UM8blvv8pFr6PbQe91ulzOM/Yz8mIsrHEkGycQO4esmaan5bG7QrKcdRMEEGWaGbLE9JGRNsHl8B
 c/9HYpxC9fPweJK9QvMVcvntpm6nKLJIwybRrSSUp+62cSIsn8ZwSlEpqi+HbCrLXorQ2jTamUcYg
 kgpaDUEITuH5tiaqi+sC2H8ZmDAjvulf/wzSzZzpZD3LF9sJlJhEraxoWMvsQpw+ULaIiK4AVLcKZ
 bW7xNDVQ==;
Received: from [186.208.74.38] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w3ZGb-003nrM-1L; Fri, 20 Mar 2026 13:47:53 +0100
Message-ID: <f993cd33-cb39-4fb4-9dbb-42abd22c3112@igalia.com>
Date: Fri, 20 Mar 2026 09:47:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/drm_atomic: duplicate colorop states if plane
 color pipeline in use
To: Maxime Ripard <mripard@kernel.org>
Cc: maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, contact@emersion.fr,
 sebastian.wick@redhat.com, harry.wentland@amd.com, daniels@collabora.com,
 Alex Hung <alex.hung@amd.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>, Xaver Hugl <xaver.hugl@kde.org>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 dri-devel@lists.freedesktop.org
References: <20260318163629.300627-1-mwen@igalia.com>
 <20260319-nocturnal-mighty-chupacabra-87cbd0@houat>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260319-nocturnal-mighty-chupacabra-87cbd0@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 19/03/2026 07:00, Maxime Ripard wrote:
> Hi Melissa,
>
> On Wed, Mar 18, 2026 at 01:27:11PM -0300, Melissa Wen wrote:
>> For suspend/resume to work correctly, do for colorop state the same we
>> do for plane/crtc/connector states: duplicate the state of colorops in a
>> color pipeline if it's in use by a given plane when suspending and
>> restore cached colorop states when resuming.
>>
>> Fixes: 2afc3184f3b3 ("drm/plane: Add COLOR PIPELINE property")
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>> Reviewed-by: Alex Hung <alex.hung@amd.com>
>> Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
> Only slightly related to this patch itself, so this discussion must not
> block merging this patch.
>
> I've been looking at revamping the state allocation / reset recently and
> came across the colorop. It's not clear to me if it's something that
> should be expected to be reset across a suspend/resume cycle or if it's
> something that should be maintained across that cycle.
>
> What is your opinion on that?

Hi Maxime,

I understand colorop should follow the same lifecycle of plane, since 
colorop
is associated with a plane and represent the color configuration of a given
plane state. So, I think it should be preserved and restored in a
suspend/resume cycle.

You mentioned about "revamping state allocation/reset", is there already a
public link for this work that I can take a look?

Melissa

>
> Thanks!
> Maxime

