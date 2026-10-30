Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B47606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=coBFW+Nr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5430A10EA10;
	Sun,  1 Nov 2026 12:00:50 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D436810E231
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:24:49 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-5430f70c827so4081211cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1793352289; x=1793957089; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RapgeB9lnSOOHM+Q+Ek+TouLYSIIJBsaMcxUoOZ7Uqg=;
 b=coBFW+Nr/GlxYrr1XxGUlEevcyd0uo7HKs3x67MGzLEuao/1NTfmuJjhRtq1nXJfre
 9kgmu6PWZ/Lotou5zFpnWjamGlEf1RPCZX6exwgLrBBqk+kpp4da6KsS7Lwvje26LBLI
 9Ae0AFJeG5aosXxHxRlMnTUhS4b7VZ5BUUzWZdAl6sID/99MEwlbviQx+WkjxzFBeQJH
 9XiEkXrcmAUNACzJuAQ4eGWDwH+J8R6K3LmJpuWqCSG93oi0n6FTpelrQrgkaZa5Rl9x
 YdHw0x2iVNECt3TDe+fzl/BRQw2/1xD7iudQkanm7jAV06aNTu8pbtPnTI8lG4iNLLad
 cR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793352289; x=1793957089;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RapgeB9lnSOOHM+Q+Ek+TouLYSIIJBsaMcxUoOZ7Uqg=;
 b=ftqIoC90vksjqqoPD1EWPoh98ZmeCpoKH4ttr0SUZ7kJCt+4QTEiaCz/63VkteAiuN
 2dWgbMEGUX2lezoESMx1P5mzkZR2uV8KM4gnq4SJ01bxTQJTUE1SQzhawwsOSVc1g0aU
 GpEtnX9leIE2y6pxwzsCbZRB7u2kELZGMBTjjayhFBDV6bLEF+4YXJM5Fl+z0oy0VfR/
 m9UpDzncyFSzYrGK7+M929A4B0Fm0PYqV9zME2/6WQOkZGJcYGRIlhqp8ieuW+W3KOJ9
 bpgUQBtQNShRT/GI0gYVJbvemhCTPqBBk7MDNR8AWXsagyz2oeoIaKEx+TKkS/pKjWqP
 Al8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzLgKsD8xf9O4M4eI96xHGLk9TOjUEgFkgyU+726PythAukTLWkqckUXZ8vo6zVUJpNYmyV71pSUE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ7zpT+yi9Nn8WaNfNJmxSBQZPe7HGHpqajFAt+BffVDSBiaGBG
 Yz3Lwm9BaMd39Ou/KLD4kb+mhwnM0F9VP/h6BaQyx3cfDTwE1YmAswyF/c74aygxMw==
X-Gm-Gg: AYBFou27MwSHTayj9TIcKECErP4p04TedpeV5C0LG1Wep+Gevy3eY/fQYUqD9fOBJgf
 DcO78COul0BuSw6Y6oLcRwGfyFE9ju5YjS7Bca/vDZKeCR7F7CF9l8Wsn59cKvhWSGRPVjdb6AI
 5TRKHtpFNKTHZ80tiBSDgZKX3TrejkyFWhb/V3EVSZ+fkxQL15izjNxocuA/dNWzcKuD+S3HIe3
 bbbh9ovZMCyN47hQ5wyWjBn/UHfMa4igIQ9gZQ2DsXP3TWenbhOLiSwD91x93DQYf/o1BSm5dS3
 i6bwm2b32YfmeBSnyJuP90vC6RNXYzHTpeVnIfns3LJ0s9138Zugy0yINKQhy7XyRPvprUo2r4g
 v0f4OMwu6lihbRSuetfzYMJvddfoEVf8d5n9KmsjDBLhnHeo4CVvAkw5a0L1gnt9yNsvgMKprl1
 7mSI77ym94A0a0zarv1v2gwbGVky6MUnrWh8xcq4rSlWoPbYZz13ji6WEnL6qYvjOMV2IH3YGux
 Wrxwj0GXEdXJsM4xB5M9827lDFShle/5bGKuVWA9jRscyMOkKkgGvm+yNiBZccCnE6J/a2caoTz
 KKb3x/Sm26NDCqkGwxA2BJg+lQ2e1OqXUih1/56hqm8JM7Y7MJcn
X-Received: by 2002:a05:622a:1f12:b0:537:deab:afe0 with SMTP id
 d75a77b69052e-542b3e68d89mr22133521cf.10.1793352288578; 
 Fri, 30 Oct 2026 02:24:48 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54311f775a2sm8848351cf.14.2026.10.30.02.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 02:24:48 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: tzimmermann@suse.de
Cc: x86@kernel.org, bp@alien8.de, mario.limonciello@amd.com,
 aaron.ma@canonical.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] x86/video: Preserve the default VGA fallback for legacy
 modes
Date: Fri, 30 Oct 2026 05:24:21 -0400
Message-ID: <20261030092422.300856-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4379fd92-ac4f-45c2-9f4a-eaabe4b7f981@suse.de>
References: <20261029162311.3389523-1-hengyul@cs.unc.edu>
 <4379fd92-ac4f-45c2-9f4a-eaabe4b7f981@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thomas,

On Fri, Oct 30, 2026 at 09:48:19AM +0100, Thomas Zimmermann wrote:
> Am 29.10.26 um 17:23 schrieb Hengyu Liang:
>> However, screen_info_resources() also returns legacy I/O and memory
>> ranges for VGA text modes. These ranges are not PCI BARs, so the resource
>> lookup fails and the default VGA fallback is skipped.
>
> If the BIOS booted in text mode or VGA graphics mode, the rsp device is
> still the primary display device. So the current matching code is not
> necessarily incorrect. (But also not necessarily correct either. :)

I agree that the device is still the primary display in text mode. The
patch gets that from the vga_default_device() fallback, since the legacy
ranges can't be matched against BARs.

>> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
>> index 8ed82fff7638..b8f83346dfe8 100644
>> --- a/arch/x86/video/video-common.c
>> +++ b/arch/x86/video/video-common.c
>> @@ -45,7 +45,7 @@ bool video_is_primary_device(struct device *dev)
>>
>>  #ifdef CONFIG_SCREEN_INFO
>>  	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
>> -	if (numres > 0) {
>> +	if (numres > 0 && __screen_info_has_lfb(screen_info_video_type(si))) {
>>  		for (i = 0; i < numres; ++i) {
>>  			if (!(res[i].flags & IORESOURCE_MEM))
>>  				continue;
>
> Further below in that code is a call to pci_find_resource(). [1]  Why
> does it match with vkms?  Vkms is not even on a PCI device.

It doesn't match vkms. As you say, vkms isn't a PCI device, so
video_is_primary_device() returns false for it at the dev_is_pci() check.

The problem is on the bochs side. In text mode, screen_info_resources()
returns the legacy VGA ranges, pci_find_resource() doesn't find them in
the BARs, and the function returns false there as well. So no device is
primary, and fbcon stays on the first registered framebuffer. In this
setup that is vkms (fb0), so the console is never remapped to bochs (fb1).

vkms only makes the console part visible. Without vkms, tty1 has the same
size with and without the patch, but boot_display is still missing without
it.

Thanks,
Hengyu
