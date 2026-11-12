Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A56606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XdMOiNNw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5278410FF17;
	Thu, 12 Nov 2026 02:05:29 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DDFC10FF17
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 02:05:23 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3b0d09df973so2943474a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794449122; x=1795053922;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qKzq1YaHaTK/cMOsuVlloBBGSRBcO+4dM5JD9G9qTYM=;
 b=XdMOiNNw1YQ2C7bCFkqnLr38QELTwFiNgXs99LYqp/KbiHRst7/iMDYQcnFizA2X/H
 s4zunRE4ANY4hKZ53+xFWYWxfgpH3IWRWV2teRdveLpoKv4B52tmYCcIOZ7bjszaacwK
 Qg5KNgPU+TvblsWGs++GFPDFdzsf7p+6Q7SpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794449122; x=1795053922;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qKzq1YaHaTK/cMOsuVlloBBGSRBcO+4dM5JD9G9qTYM=;
 b=FirU25c5KEr+y/F7jWu9qfpz9PVDx71794reDiIZ0fNnSX3jXXD2pDfqOybXx7Ss9w
 18Dv5ZdewLU+yHpq7uHK5Dw0Ya9fp5rshx/XteZkU6oTD00RQTD0WyUi4bszXWy2R1PM
 L5EguaRG5paIv08P+1+KlZIrHAoVHSGiryripCLcDlYRtjZ5M/NrkjpAeiGqJSfMLXm8
 0K0j2K4DjayDeh3+avxKFvkR1iXzu7Qn7rW+2mtIQlvHB7U6oU5lXaKKzxiL57dV8ftD
 LTuXRhNSPK3tYKJfqhJ5QCREgZk8GvI+ser32yF0NLWxUZ+145ZV0XQSXeRXmx8+or58
 KdwQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHfRemV2bV5amSpjep0ifvVDBBDj6/dEcHqe3TUJdb+hcIVtee/PHhJHis1hnFBOUoAvnb7jl+WygI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8l/dnGFyEtXP7pWRtvEP6hXoJg7GeRjW6Zbtf24sXzxrcGW2EM
 fLnIwx0E+CccdDGmS8k/4G+GHhb5IT6zKGvoJ2SQeiiTUDRy/XJtHH7cO9jklMq/3Q==
X-Gm-Gg: AYBFou1rMCCA2qPxsIK4ovX70h/O1CxV0gSsPaT1JMNAL8yVhWwaLgVQVcXPMTogStc
 BrX5hq7yKWNwKza0COaO17Jo2bbik0LcL9gDYDl88CGcPkjpZ/o2OGn0fNaWWgxefNOFwJ8NRP7
 lNDlI7snT35tu6qHciuzPX0V/530avW6zqaAV40pH6fpv1OGtHbG63x2RmjBOvPwnlOwFHACVR7
 8+RPf6E087vBriYYXvxoTrHVtFZF8K+sUU/L/ubHUszNf3SdpXZu7bjZYzoZrP9jTquYozrRw4E
 3mR3q+hQ0oYGGUakdC4g+HFTBQUtOXOKMMN5YFeAAs/ZPBYBuglVUPu6hXbC627sXWWQyTQxnmM
 guA9I0TCwOS4jRHef4g4vNibjKN6j8zuJNOqIiYJFxp7jmhVmFKooDK0zIwyHB9eD3YQQWq8T/j
 Pf9bNlLPGb/n/ECdBJeSLWMes5MwTxwDk7NN+ryASqLtV6TyVUAZKimFGcrl6H56nVH1sWUMjpr
 GI/QugXGpsE8XBWtYtl1ijTp3x9GbNrEXvCpzs4ac9nbgZ6JSXCRK7MoYpPhabaHByp/Zruymlb
 2fzdvgkWshMsw+VS/fI8JLkZi0vYlyNtYSux11Z5d219zxoXKzKabnL98DTaw9FYh1f7Xw==
X-Received: by 2002:a17:90b:4ad0:b0:3a7:3474:b1ee with SMTP id
 98e67ed59e1d1-3b182f1adcdmr4140105a91.60.1794449122530; 
 Wed, 11 Nov 2026 18:05:22 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:ace7:ac44:3dca:1bb4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197c6c9c5sm1832060a91.1.2026.11.11.18.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 18:05:21 -0800 (PST)
Date: Thu, 12 Nov 2026 11:05:13 +0900
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
Message-ID: <avUet_6jVqlWSP00@google.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On (26/11/11 20:41), Xueyuan Chen wrote:
> CONFIG_ZSMALLOC_STAT only controls the debugfs interface. The class
> counters are updated regardless of this option.
> 
> Remove the CONFIG_ZSMALLOC_STAT guards and rely on the debugfs API
> stubs when CONFIG_DEBUG_FS=n. Skip statistics setup silently when
> debugfs is unavailable.
> 
> Remove the Kconfig entry and replace the existing CONFIG_ZSMALLOC_STAT
> settings with CONFIG_DEBUG_FS=y. Update the English and Chinese
> documentation to match, and clarify the pool name in the debugfs path.
> 
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
