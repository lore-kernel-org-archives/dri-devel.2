Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B029606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 02:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=VVKDCu9m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE6FA10E2B9;
	Fri, 13 Nov 2026 02:19:41 +0000 (UTC)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E655110E2B9
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 02:19:35 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-14394530ec6so545616c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 18:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794536375; x=1795141175;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ebdv6ZUT/HH0C8QcvPGAmiBNBGZr0ii2abVsK2I4hFY=;
 b=VVKDCu9mmyqjvHvYpKNV7iFadZoWskyTTSsCH8e9z4AlaYpi/iEXHWVUr/++UqpsGM
 VsJyLh9ai53XcnkZVp924ojnMLn/th6npXDCbfwh0qslwBzKW3SNP4UX+6o214CsvlDv
 gKHpW0hB5XaNuPyP6zF5VqoyGBqX2nPZ/NB+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794536375; x=1795141175;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ebdv6ZUT/HH0C8QcvPGAmiBNBGZr0ii2abVsK2I4hFY=;
 b=IMA3l26bM5pFVwuMqrNKN8Nbm/6moFIFjQq9Q9cj/bUCLIEZqqR4A5Pe5CQmgfGwzG
 IJjuCbMl9ax+w0JyKfeGpvU5hdXRvbnsYIC3Ht+Qdwfs7GYCCC3xo5jyZQA+pZJ2HxRr
 8vD3v5a2HhujBr4thxOsCi+WWyV+ezM6W7t4SJloL6mfNXfWsSQuIQAFrcJe3nKjP8p9
 K1iFivcOxkFU90yrkg1CjwnD8TrKppQzKLN4x9r6G4LxCnxi31y/xCPgGVgTSp2G66DR
 tKpXiOUslCh/JD8yIbDkJhagt4pynPVRHd2o4m4668tU1CDtOFOoOrb5efFpquTmX0yR
 pGOg==
X-Forwarded-Encrypted: i=1;
 AL+hErGYEq3d1XJ10bNSe+5DpLNaMX2Tx1dUfRyP7eE+H1tEVBXs31QC63i835OR6v/lTEpVo8kmkuQVUeU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8O+DRm9zd+ktu4CQIIe/Yj7umV0D8cz+qu6b3TyVoogbRY6Z4B
 nHQaBCrmIcTUbh32ws92iVjlfcHU2kadYbgTsuJlLg145EurDUi0ODoUDLQUXDQL4w==
X-Gm-Gg: AYBFou1cLZMm1wett7a+NCsfaectSN/G25tU8VvIWp2LBrgfA7IdeVkVCXz87cqUU2Q
 /Ccu4p9Dv2zWNhHGqa+iMmlFdvIoCEbEvptMWJz1/TGhD+1hsONem0ddsv0W7nBOAIE6VspVeYO
 xIH66HqDLb838QNZqwzWGvHXlazyZEm55O+hCRFKe6MeGFizBkxey4Hfv0sxTbIKPNRt+M1STdn
 I0MxBTsn4D6xa7Wj2JT5b1tebG2uz9DvtiIaUoMI2otNOtl0AxHrIBNc+lnPH85oRyGU5Wbbn8f
 P4ngQJtbc/1z1GXrfkH6XKxr4JbhTTC5mIzR2YXiPd+ajA1Q9RpvyHFSu+7/cDGhKdJ/y8ILvSj
 6NJ3+7OUEMIFNEqHzAmEvAoDQkJDm0d0E64qSUVpHfRskQeO4NicksZukM9Gh+3F8DqsFFiyLUT
 sC5tDSDqWj2rioPxeYvXWStB+lAORKDD8W3kK5MCTzHZIO4UdEfeIDzZAdTmTZtYENjTOPapeiY
 JdSjtWuDob7ct/dGThg5OLD3wO3HhPN0rCnoiX/R8po3nWmif0dVDjVFfA/sJcTUORpr2EEgjJA
 GJQoOQjBkh3LDNZnzdKogp5U1B8IF5iHa1SwyvzwAUwiV/mYqf8x3+lFvLuhrYwqTKaHSg==
X-Received: by 2002:a05:7022:3a03:b0:1a4:9eaa:d01d with SMTP id
 a92af1059eb24-1b50315d8e2mr1234175c88.45.1794536375046; 
 Thu, 12 Nov 2026 18:19:35 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:3f2c:d0f6:e2f1:e609])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d269asm2477887eec.23.2026.11.12.18.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 18:19:31 -0800 (PST)
Date: Fri, 13 Nov 2026 11:19:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
 Dongliang Mu <dzm91@hust.edu.cn>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, 
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v3] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
Message-ID: <avZyo_hCRonuhXW6@google.com>
References: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On (26/11/11 20:41), Xueyuan Chen wrote:
[..]
> diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
> index d2bbecd78e14..4c0786378dc3 100644
> --- a/Documentation/mm/zsmalloc.rst
> +++ b/Documentation/mm/zsmalloc.rst
> @@ -33,8 +33,8 @@ proper handle-based APIs.
>  stat
>  ====
>  
> -With CONFIG_ZSMALLOC_STAT, we could see zsmalloc internal information via
> -``/sys/kernel/debug/zsmalloc/<user name>``. Here is a sample of stat output::
> +With CONFIG_DEBUG_FS, we could see zsmalloc internal information via
> +``/sys/kernel/debug/zsmalloc/<pool-name>``. Here is a sample of stat output::

While we are at it,
We use zramX throughout Documentation/admin-guide/blockdev/zram.rst
and in some other files as well.  So let's just replace user/pool name
with

	/sys/kernel/debug/zsmalloc/zramX/classes

Here and in the Chinese translation.
