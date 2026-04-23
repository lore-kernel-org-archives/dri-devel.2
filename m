Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2389AFDEE45
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5981C10E36E;
	Thu, 23 Apr 2026 19:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QwavcUDQ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8E110E36E
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 19:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776972175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wSQkzxpeA1S/sXqiIjkU5AWADgODzfZs9CPZ+3hRtvI=;
 b=QwavcUDQmRIucAL5opUdP/EKdSLeMnv0xt0vTh5iIvd41Sjkjw02YaNs6Fvz+kSLcwsZ+O
 fikUM7N/8ob5c94I10sKvgncGbVfyVnyvFURSbViCu/cbhsIvQZ+TKlN1uo+Wqecnm5AUo
 n0S4BDB7ElkWu2lUjHc5o2SgurBTPJ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-PvQc6jV2NHegTo84Y57Jpw-1; Thu, 23 Apr 2026 15:22:52 -0400
X-MC-Unique: PvQc6jV2NHegTo84Y57Jpw-1
X-Mimecast-MFC-AGG-ID: PvQc6jV2NHegTo84Y57Jpw_1776972171
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488c768a9a9so49159545e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776972171; x=1777576971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wSQkzxpeA1S/sXqiIjkU5AWADgODzfZs9CPZ+3hRtvI=;
 b=e9btFy2msV/HbX+ipXJ2B3VTjrOg/CQx+Sv/GnD5mmsdeUd9u4hrr0rc0Tj0PczalC
 V1MLtsRYIicZMFnAIGk08rK7MjbMM18wGp2h60TEGlCi9MP+F0mDGOxEyjzuQoior/9q
 I5EisOz4BnOmAV5fylgk8g5N3zLvQ+8rFzugtFMFLzzawFQmzofbv+EeU1oGD76h6N4A
 YA43vmKsBNTH/IqcZswTeUpO6d45xDR7hAgjFdcJ+JumnE/k2NERmmfa2jyxkDI+1bNr
 vtjiy3M6q2Lk7ubnFqiP8yuIohrYQ8GI19ButmNp3C7q9jlSeduIyEWGX16qv8gLvf5X
 JY/Q==
X-Gm-Message-State: AOJu0YwVDFWfHtfucfGFPyXbSe0ZWBmyxqc0bqPp9uVSZSfeuH8SPPLF
 fDYDR27yktiOfYUYjdtoNrj4DdHF7mBin5tK4J5XngmTKg9HoCiO2h0Ie9BB3sP78xMUUhMwbVL
 z5egHt4uELHTh4CpavRGgNEWMQ9vnWlziKO/+dAxc9kn4UKLY1B5auSZDlar8w0CEtOX5XQ==
X-Gm-Gg: AeBDieuPt8ntyMqq3OGsea3he5KnzyfmY6NUR+KMQq9qgUcs6RvTCfOSafbfNYZpaVf
 ckoU+Gs7PsKNLvWGhjVvQE3PzxBkEhUd8zhjjaMoRmxdEZdSd9IcFTUnC+9dsFN1jfvwsOiTi/7
 jOrALixWyu+PyMVGPHRHF9QVWeHnCfQOIuBU8cvjvNA5NcFwnTbxl5JI+dNIZVtD5yono2ekfpe
 OxqJ9R4UmB/arM90fIQ1Ol4q4UmVQOUURAtGlXzsH/9/LxcN3ytSbqVZiqPycQSY4/rlet1NF4X
 TLG7Qlerapuj3uwztXTZlMRnU3gqypqSprbBnGVa2zPJA3xpl5QgUNm+IH11eijxskkVUxCukqO
 VhTQqeImEsRdWY65e+qim3Rl/UDU88XDmDwRcSiDvZh0xLFNdfitz6PmoDNdlS/1SwiluyHmW
X-Received: by 2002:a05:600c:8b84:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-488fb76e4aamr444109045e9.17.1776972170705; 
 Thu, 23 Apr 2026 12:22:50 -0700 (PDT)
X-Received: by 2002:a05:600c:8b84:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-488fb76e4aamr444108865e9.17.1776972170228; 
 Thu, 23 Apr 2026 12:22:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891b46cffasm359609565e9.13.2026.04.23.12.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 12:22:47 -0700 (PDT)
Message-ID: <14aa4840-29c4-46df-b60d-8e1b92494ad2@redhat.com>
Date: Thu, 23 Apr 2026 21:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: further issues with MGA G200 graphics chipset
To: Jacob Keller <jacob.e.keller@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "airlied@redhat.com" <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pasi Vaananen <pvaanane@redhat.com>
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
 <a9d176ec-d19b-4f41-af16-cdc4e475a8cc@suse.de>
 <6ec01703-31e0-4998-9508-a5a115ae7bc9@intel.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <6ec01703-31e0-4998-9508-a5a115ae7bc9@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bHz-YKbn2BFiU-6oyP745jB9KX21TMYuQoIkvHKzX6Y_1776972171
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
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

On 23/04/2026 18:35, Jacob Keller wrote:
 > On 4/23/2026 12:44 AM, Thomas Zimmermann wrote:
 >> Hi
 >>
 >> Am 23.04.26 um 01:55 schrieb Jacob Keller:
 >>> Hello,
 >>><snip>>>> I'm also curious if its possible to stop polling for so 
long with udelay
 >>> in the i2c logic somehow? I am not very familiar with i2c, but it is
 >>> frustrating that this driver is causing yet another stall that is
 >>> impacting timing sensitive data. Even if in this case its due to a
 >>> faulty cable.. it is frustrating that such result causes the PTP
 >>> failures. Would switching to WQ_UNBOUND be helpful here at all?
 >>
 >> Try Dave's suggestion to avoid polling.  The driver won't be able to
 >> detect changes to the connector status, though.
 >>
 >
 > That's fine. I don't think we're even using the device. It looks like it
 > might only be in use for BMC, and the VGA connection isn't actually
 > physically available, so there are no changes to detect.
 >
 > Is this polling really only to detect when VGA is enabled? Would it make
 > sense to only poll on platforms which actually *have* that VGA 
connection?
 >
Polling was introduced with https://patchwork.freedesktop.org/series/131977/

The driver needs to know if a VGA monitor is connected or not, to 
provide the right available resolutions to the userspace.
Otherwise you can set a high resolution that works from the BMC, but 
then connecting a VGA monitor will not work, as the driver won't notice 
that something has been connected.

The mgag200 doesn't have an IRQ or a register to check if something is 
connected on the VGA port, so the driver uses the i2c and tries to read 
the EDID.

Unfortunately, there is no way to know reliably if a VGA connector is 
present. It's possible to disable polling on some machines using DMI 
quirks, but I don't think this approach will scale.

 >
 > I'd like a solution where we don't have to go to each individual
 > customer and have them ban the mgag200 driver or set some kernel
 > parameter like drm_kms_helper.poll=0 to prevent issues. If the VGA
 > connector isn't even available to *be* plugged in, then it doesn't make
 > sense to constantly poll to check if it was...
 >
 > Many system admins likely aren't even aware of the devices existence,
 > and it ends up causing stall issues like this, which for timing
 > sensitive tasks results in service disruption.
 >
 > It is unpleasant that the mere *existence* of the device+driver causes
 > such problems.
 >
 >> Best regards
 >> Thomas
 >>
 >>>
 >>> Thanks,
 >>> Jake
 >>
 >

Best regards,

-- 

Jocelyn

