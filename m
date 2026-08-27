Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27817C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 673F010EFCC;
	Thu, 27 Aug 2026 11:25:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=freenet.de header.i=@freenet.de header.b="MAMBkUrT";
	dkim-atps=neutral
Received: from mout.freenet.de (mout.freenet.de [194.97.212.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E0B510EFCA
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 11:25:32 +0000 (UTC)
Received: from [2001:748:400:1319::5] (helo=sub7.mail.fnrz.de)
 by mout3.mail.fnrz.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port
 25) (Exim 4.98.2 #2) id 1wzYEV-00000009wha-3Rq4;
 Thu, 27 Aug 2026 13:25:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de; 
 s=mjaymdexmjqk;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ueNIILVqEC1EDlhHvSTI9jKDjqOLekmKBTTru+JqTKQ=; b=MAMBkUrTPun5cXvKCc1d/bEtty
 cwhqCD5m7N7CXXLFtRw0RbyD2M9HZiOvnXUfTP0STXQe520di7ujFVEUqYLhpyrFCRXo1qt5qMeR8
 kCOz9sxFO1+MNBsbTqvyCakiHkO/15fzROuPrg0JqpGQxlyCv+ehuR+5dEJVVwVNMmT1Y9LDRNePD
 V8Z1io3YYn9TvzcZM8DRWokZkYthR7P4BwKY4hYuvYmLWostNOUim+09GiXy7ft54LREuMPxxPEo7
 Gm1KL82UoTBujAoAW7abNjFDuqo2oBWdiDW1TA0YhoKOuMMxW6yZQbWIR5DXuI4zRBTQRxyIIHIbo
 9K77p8Pg==;
Authentication-Results: freenet.de;
 iprev=fail smtp.remote-ip=2a02:8071:a85:f020:30e3:6d19:8d01:b666;
 auth=pass (PLAIN) smtp.auth=viktor.jaegerskuepper@freenet.de
Received: from [2a02:8071:a85:f020:30e3:6d19:8d01:b666] (port=33284
 helo=[127.0.0.1])
 by sub7.mail.fnrz.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de)
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim
 4.98.2 #2) id 1wzYEV-00000003c3q-2hZl;
 Thu, 27 Aug 2026 13:25:23 +0200
Message-ID: <29aca774-e502-4e5b-8ebf-7319bc8df77c@freenet.de>
Date: Thu, 27 Aug 2026 13:25:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm: use drm_warn() in
 validate_blend_mode_for_alpha_formats()
Content-Language: en-US
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com, broonie@kernel.org,
 daniels@collabora.com, jani.nikula@linux.intel.com,
 miguel.ojeda.sandonis@gmail.com, pekka.paalanen@collabora.com,
 simona@ffwll.ch, penguin-kernel@i-love.sakura.ne.jp, tytso@mit.edu,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>
References: <20260731154232.37020-1-leandro.ribeiro@collabora.com>
 <20260731154232.37020-2-leandro.ribeiro@collabora.com>
 <CAPj87rPvh6cz1JmRjfev5VJWZHhZqwyPn_nA3x43q6_qVDf=Tw@mail.gmail.com>
From: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
In-Reply-To: <CAPj87rPvh6cz1JmRjfev5VJWZHhZqwyPn_nA3x43q6_qVDf=Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-FN-MUUID: 1787829923B2EDFF0DCBA2O
X-Scan-TS: Thu, 27 Aug 2026 13:25:23 +0200
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

On 8/14/26 15:42, Daniel Stone wrote:
> Hi Leandro,
> 
> On Fri, 31 Jul 2026 at 16:43, Leandro Ribeiro
> <leandro.ribeiro@collabora.com> wrote:
>> Commit 860e748bddcc ("drm: ensure blend mode supported if pixel format
>> with alpha exposed") introduced a WARN() to let driver developers know
>> that a previously valid behavior should now be changed.
>>
>> But WARN() should not be used for that, as it's a kernel warning report
>> mechanism for conditions that are not expected to happen. It also
>> produces a stack trace. Instead, a simple warning-level log message
>> should have been used, as drivers were expected to trigger the
>> condition.
>>
>> This is causing problems for fuzzers, as they may stop when encountering
>> a "BUG:" or "WARNING:" in the logs.
>>
>> Replace WARN() with drm_warn() in this function, avoiding these issues.
>>
>> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
>> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
> 
> Thanks, this is:
> Reviewed-by: Daniel Stone <daniels@collabora.com>
> 
> I'll fix up the newline when applying.

Hi Maarten, Maxime and Thomas,

can you cherry-pick this fix for drm-misc-fixes and send a pull-request
to Dave and Simona before the end of this week? I think this should land
in rc1 because people are already complaining about the warnings and it
will take some time to fix all affected drivers. I'm not even sure if
those fixes can land in mainline after rc1.

If you don't have the time to do this or the other fixes in
drm-misc-fixes are not yet ready for mainline, I will ask Linus to pick
this fix directly.

Viktor
