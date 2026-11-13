Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E529606A332
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA36110EAE2;
	Fri, 13 Nov 2026 09:00:00 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0FFE10EAE2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:59:51 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-8b0d126f631so7453127b3.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794560391; x=1795165191;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7rNzRbJ/55BT46qZauMU9GkZ1yJMZW1L/iinWzPbSDs=;
 b=RlfT5zn2gKLFiLIhmhp77G7ZcwcZEOGKEX6OdrgIQ+8+qY3Am/IpbbNGx5uW3GXM5P
 lDXFd9/5LOrCZmHjlLutTpohQJObSRCYt3f0R3GcfpXjDEjP8FAm/U7+N8BJlL8NKKQ4
 MXXNVpqe0TIWwyga6uJpq9PWjAIEVSp3WEPgzTU0utwwakfHt4vtp9Zlo8DBV5AlSJDV
 hR5j4P14TH45N3uAzh6J+HYSwl2Pd9g9A9W9Xn1474qRlMCXUhG7XDAeJbiHty6xcg2s
 q3sniDzNPb+8B4cFqZIkuwxd1PVcVr6x+rt9HESpIjOAgtuj6fCSDqs868oY0DurmR9p
 iY3Q==
X-Gm-Message-State: APuU4Z+hn0e+xvm9UwZF0dv3/fYiXw9kG3TvVLTeuHd5ZMvOyQjoxCTz
 VF0A0ACA054pk0oo8b54b45JeZMCX0tC+Q6qbQm8LNJudxOK3ytByQ4W
X-Gm-Gg: AYBFou13WIybNLgEFMWM7Gv6rN3kF38Usy5jxaYD3x2xJoc9x2FuOwO11xd/TscUZfj
 fzc8e8Fuj9jy+4AOL5ZnwiBXxHxL2Cm63QEl1alIFTr06ibwjVKHKQ3DEbaVRlC97fnXapSEsEE
 pCWp+seawxE/uGmER/YPyyqyZZAb1/TtNoUa8Grla9cde7Idl6jWf2HUqhXt2sQMpvCLUwwqGx6
 8JeUgYb2PLFdcCSz18S1CUfKClsmyWujlv2WZt5oRt1Pl91ZvJBaKL0vRMbapSuIt8zw6MPtyk9
 K//2nzR8EpUE7yDAzPQJQKF8Gs7MlwR74NBF2K+g0XzF3p0i0OiV36fRNB7uossmrW+6Gg9mtSm
 GkvyF6wskCY7CnxH7apVtgX0AnTZ0/gtl/WrNRRfL0qi9t7IMG9jDDMWFpWeAasLObpfV3pOghB
 sRtDkyDpACYRp2i+s3lriq8MbIHRjloEzjRTeoWoy0+lYss5V4AroHkpeX0PaqHIgt2l4tU4+Vj
 TvOKOFpGUdahPea9q3Zyi22aLornc8wi3UOvJWsicwPzi5ggRN/CMYQzht4//1rnzQYr3juH1py
 el7uwgLBryhC+wAytlFm7EyNX6J6ZEKg361CEj/wlzocmqDwvfyWo9mYovibwBz6ItJr1/tZt2J
 O6tJkQ5TtxFlBJUo/Xcadm2GNjxaKn7Vk
X-Received: by 2002:a05:690c:386:b0:8b1:e7c:cdcb with SMTP id
 00721157ae682-8b4aa2f2467mr15379307b3.23.1794560390743; 
 Fri, 13 Nov 2026 00:59:50 -0800 (PST)
Received: from localhost.localdomain ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa7ee70csm15720497b3.6.2026.11.13.00.59.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 00:59:50 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
To: u.kleine-koenig@baylibre.com
Cc: dri-devel@lists.freedesktop.org, patrik.r.jakobsson@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, alessio.belle@imgtec.com,
 luigi.santivetti@imgtec.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, imagination@lists.freedesktop.org,
 frank.binns@imgtec.com, operatingsystemsdepression@gmail.com,
 matthew.brost@intel.com, dakr@kernel.org, phasta@kernel.org,
 sumit.semwal@linaro.org, linux-media@vger.kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 12/13] drm/powervr_sgx: Add the DRM driver,
 power management and debugging
Date: Fri, 13 Nov 2026 03:59:47 -0500
Message-ID: <20261113085947.62594-1-joseph@telaak.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <avajebb1alBnAm8U@monoceros>
References: <avajebb1alBnAm8U@monoceros>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 07:23:36AM +0100, Uwe Kleine-König wrote:
> On Thu, Nov 12, 2026 at 05:59:02PM -0500, Joseph Telaak wrote:
> > +static const struct pci_device_id pvrsgx_pci_ids[] = {
> > +     { PCI_VDEVICE(INTEL, 0x089b), 545 },    /* CE5300 family: SGX545 */
>
> Please make this
>
>         { PCI_VDEVICE(INTEL, 0x089b), .driver_data = 545 },     /* CE5300 family: SGX545 */

Will do in v2.

> Don't include <linux/mod_devicetable.h>. of_device_id is already
> provided by <linux/of.h> and also by <linux/platform_device.h> without
> the useless dependencies that <linux/mod_devicetable.h> introduces.

Thanks, I'll drop it in v2, and check the other files for the same.

Joseph
