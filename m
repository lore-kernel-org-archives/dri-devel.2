Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4911CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 04:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC2E10E230;
	Wed, 27 May 2026 04:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pt0FvArZ";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 848D710E230
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 04:17:32 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-365cae89bf5so5044737a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 21:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779855452; x=1780460252; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rMrQsiO+F96iPcmJ1AhLPXwczUDQvqynkahxXerRItk=;
 b=pt0FvArZjamp2mV7g/y6epG6wqSPPyyjV9pYTGWpr57qjrFnLXKS4+ohXvETCTPvup
 evJreXUpZYxneo0g4TbfhdSwaoMi9AxrKMBhoBdEzazkKXJ2NpWBqeMvfxc08/idh0eq
 oJwi//sh2yquKm+b1cabAjOG0hFfoMiy1HHBlfXLSUyY1aK7GCGmyZ6ttO8jYINeJpgp
 n8z8ACojH23uy4u/rKBGHXFqb1+dO0Q1/7hau+aYDpSUFFM4LnIufPJHdcljO3VAPbph
 +sBeOUC0UxW4diOdDnjaMYRlxpSWzwMl9Kq/RH0hLioau/gaCCsSC/2KsS4koYUbTDK3
 o68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779855452; x=1780460252;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rMrQsiO+F96iPcmJ1AhLPXwczUDQvqynkahxXerRItk=;
 b=dkXUNDokp8pm8Hfq7vbjNjrH5L8otbVX5N9M/mH/oxpsRGYnLL0YcqRB3MtBO+hdZb
 v2xJxfdehgNR8uaaxZEwZep6KZtjb2zgAyrUzDckFfdCfcJWhQItXGRoboe7BL3mPP/j
 /vIEHXXV62NpZnYhmrvXaubxyQI62QpBLaQXNdVJo80dSTnS9AWVL3ul2ggsX/WK0XqY
 csQs/8UxOT4WXEyRoVjQCqi5m7FPQcqCcMnjP4U+yOZ6t/b5ueUX+2aKug6jWYeKOdyM
 3mt9zpxvl+qnc/egA2cGT9tRewYeCGCjtDqwJZvlNpwOXz+W8bTCVbpOrwziN+0ZnhmD
 wzDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MHHMEMU1OR52v7rtIRsDm04+a/ij3ANmFeuFFa0G2nXrBmliYpuMZkyrUTqZSPnyA7ayqof9zYko=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZvWVauK1KTMbbHKfaNiZDuqK27im1RJ9spPNZAljkBxydSSjT
 hwX4mZC7+BrhZem4wi/ixYAQOEVt0sD4x57sqZXLMQS9Ij9chiPQjujs
X-Gm-Gg: Acq92OHsD807ohHU/qZuTKvM6Q4CdD2aElRLl+RMnqfAnPDZV9oMjTrKpV6KNgFUuRU
 liwPqcdsrfTPFstC9BQBl7rRc2kNW4vuwBX7V4yXadnfNY0GqhseVo67A7UC+IS1+jZ+y4ewNa0
 kiIKm2kYaI3XO8O8rOoNzH3iIMAvfmEhuszMDQ7Coboq67snfwgAVliA4tRqHuONNmTJMTkyf3I
 mMPobomsRbBJibMWZou970yUgI4AqqdaUa83gslaEvyh6BJgxeQmdMJo9J4RGHR4EvxIQMRomU0
 UHMfUrsvCAWBUl0TKOj2wwpx0Km7AHz4oPWsH8ku6H55vXxp2Iad74BCrCFlnyMDqQ8oHK4FORX
 eZXI07kNpsS1+ra7utEFVUzh3HdIsNwnAOEu/QUL0anVGCuAqbWLqDwBf9MwmHVs4qhhF8lDGQU
 fwklTjlxckU4Pl9eOnxTaf/A85jBi8v8YAoiXCrmwNs2pPJUKfo7vXP9JABkX/HLPtw3sLByFdA
 sqWDAEwomz2x/uCwnTzz08rVN+Z9wJ5MHs4myeHQG6BmowawxTyULUFAOK4CtQCqJznRHEMFSYT
 Wiy2BtFRH+phSZ5mplhJyYgrUfZxFrrMxiD82PDKU5d/
X-Received: by 2002:a17:90b:2d4c:b0:368:ed26:15b2 with SMTP id
 98e67ed59e1d1-36a67461a35mr21338047a91.8.1779855452094; 
 Tue, 26 May 2026 21:17:32 -0700 (PDT)
Received: from ?IPV6:2601:1c0:5780:9200:8926:6fea:c968:ad19?
 ([2601:1c0:5780:9200:8926:6fea:c968:ad19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85205855dasm12996099a12.31.2026.05.26.21.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 21:17:31 -0700 (PDT)
Message-ID: <24a8d461-7393-4a37-b23c-3cbf44060350@gmail.com>
Date: Tue, 26 May 2026 21:17:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/panel: novatek-nt36672a: Inline panel init
 sequences
To: Alexey Minnekhanov <alexeymin@minlexx.ru>, sumit.semwal@linaro.org,
 neil.armstrong@linaro.org
Cc: dianders@chromium.org, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260523035734.6602-1-chintanlike@gmail.com>
 <ace48664-cd7e-4cb8-8940-04ffe6f93e19@minlexx.ru>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <ace48664-cd7e-4cb8-8940-04ffe6f93e19@minlexx.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

>> @@ -162,8 +141,8 @@ static int nt36672a_panel_prepare(struct drm_panel 
>> *panel)
>>       dsi_ctx.accum_err = nt36672a_panel_power_on(pinfo);
>>       /* send first part of init cmds */
>> -    nt36672a_send_cmds(&dsi_ctx, pinfo->desc->on_cmds_1,
>> -               pinfo->desc->num_on_cmds_1);
>> +    if (pinfo->desc->send_init_cmds_1)
>> +        pinfo->desc->send_init_cmds_1(&dsi_ctx);
>>       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>> @@ -173,8 +152,8 @@ static int nt36672a_panel_prepare(struct drm_panel 
>> *panel)
>>       mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>>       /* Send rest of the init cmds */
>> -    nt36672a_send_cmds(&dsi_ctx, pinfo->desc->on_cmds_2,
>> -               pinfo->desc->num_on_cmds_2);
>> +    if (pinfo->desc->send_init_cmds_2)
>> +        pinfo->desc->send_init_cmds_2(&dsi_ctx);
>>       mipi_dsi_msleep(&dsi_ctx, 120);
> 
> Hi!
> 
> Here, the split of panel init sequence into 2 separate functions _1 / _2
> is completely artificial and completely unnecessary. For some unknown
> reason the initial version of driver had initialization procedure cut in
> 2 parts on the boundary of exit_sleep_mode + set_display_on commands.
> 
> I think the whole init sequence should be glued together into one big
> send_init_cmds() callback and have all these calls:
> 
>      mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>      /* 0x46 = 70 ms delay */
>      mipi_dsi_msleep(&dsi_ctx, 70);
>      mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> 
> 
> included in the middle. This opens up a possibility for other panels
> based on nt36672a to be supported in this driver, which don't have the
> init sequence split this way. The location of exit_sleep_mode and
> set_display_on commands there is different. And, importantly, the delay
> is different too.
> 
> I once did a very similar change to this driver [1] to add support for
> more panels (ignore touchscreen changes there, look only at panel).
> What is also important, that change was also tested on Xiaomi Poco F1
> (xiaomi-beryllium) phone, which is the main user of this panel.
> Unfortunately I never got to send it, even though I wanted to..
> 
> What do you think?
> 
> [1] https://gitlab.com/sdm845-mainline/linux/-/merge_requests/131

Hi Alexey,

Thanks, that makes sense and I agree the fully panel-owned init sequence 
would likely be a cleaner abstraction long term, especially for 
supporting additional NT36672A panel variants with different sequencing 
requirements.

For this patch, though, I was trying to keep the scope limited to the 
original refactor requested during earlier review:

remove the command table abstraction,
inline the command sequences,
and preserve the existing init flow/behavior as closely as possible.

Since moving exit_sleep_mode, delays, and set_display_on into the panel 
callback changes the sequencing model itself, I was thinking it may be 
better handled as a follow-up cleanup/refactor patch to avoid mixing 
behavioral restructuring into this series.

If that sounds reasonable, I'd prefer to keep this patch focused and 
address the sequencing abstraction separately afterward.

Regards,
Chintan

