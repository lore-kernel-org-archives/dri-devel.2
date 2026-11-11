Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACAD606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704611120EB;
	Thu, 12 Nov 2026 12:55:52 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DCD10EA75
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:48:55 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so1019162f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794415734; x=1795020534;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hIh1oJXmPJn8/bufJnOWwv255cbPbO6RJV8+iEpFNQw=;
 b=QwrHxpCgaD6ttTL6oR2F+jlkAUWH7CeLAaEs2aVQV+5ERDl+NLHEespRLagX26/4G3
 yHstbVWQm944EG3JS27Ko2qvWQ6S9wmkrrxvAhlo0pGjUwsTN4PWBkuyC+U+3bCIMEED
 lLldQBJFE3tvG62FOmgJGmyGOD6wIUoOUwN+/8WqTWXmW1p/0Ehv8SOy9+V2+ImZeJbS
 ILscN39z8N2H3yCaa5ArKrVdyoivXByhXKkU9NZhmxeDxHTKTOAH5ghM0N7bycqB9eqP
 9cBqQNTu/jOy46pzs4NvSoJgCk+8ZIc4jBy1QLCbDmdtuUql6Jzm3bhV06E5zD9mZpcd
 KngQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFyoATtYPaQyRFhc8P2R522nzPqqN83BuMOXHenboZDgktblC+yHNn7a/cCx+oXubNA/Hh89RYIhk8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8QPu1p1sWwwoQxgw1KB0HwnSYW/PhFdPCQ/WoHulwF6UkqX+X0
 CW5mTG/aFMHm+SRKdRQ+AC/4K5PMRovV63OwaTKmaAh/HfClA291GyuU
X-Gm-Gg: AYBFou0gG7rngZ6+X2b39uwtJxpy64HwA9oeiVoC54EmmfQO0MO324snlJAURssXUkm
 m7t5tbW3yTa7PcnEWGvc6pVd3WEnjXpJvr4XNA6qhc+D6eaKrMq9RGB5Hz2elM1zqHZSNuG8mF5
 DHKCYxH/0Hl5sps0XblFJfqSr5D9lQQuc5PapVN+7XvIMVPJQ8tYpPFRpjLE5cnc4DEO2Tc1CCk
 qL5ST+Ag8ZF5nmHvcZ4x0l3hNZVQy8VH0lEb+7HFq3/8twWK7Zplm37Z8Ys2poBF2326kK4FlAV
 q1zV1r7CMDYGYVInqxTccm9Q1mCmgiIZRwcPmYhY6gHMmezHa5TDJIBsBLi6KPqgLU9qLmH4YFl
 5Gu23OEEOwf74U07ysrybUNpYjsMivVToVdTeHOxDm0mBk/NrU0HaTpwZSX+nrHZarrql2a2yky
 joMn+X5Nzl2fLF/LpN1gekvxYUMvVKry+ts1KfFyl1Xv5qJ9vsG6D+1x7hUdGpeOY/RcYeDk1/3
 pF+626ek9/A0f4ZV8kiQiHSjLpzR+7Ms9TDVZKDBgQ0aanQXTNECxSPVZWmQ2J02uvcZsv2HkM3
 jSqH1no3/kQsrdPfU3W+DQ74xWh74dTOGChPSSWz6dwbxRAwcbDch8vIoxXQs6PaTWk6ue7vYzq
 qWI3nesOQok+ltvbD/PgBSOn4B8wrRsk1BoSubYR1+H85iP6BoWrLLrW/1mq9
X-Received: by 2002:a5d:588c:0:b0:499:53b3:39be with SMTP id
 ffacd0b85a97d-499c8d5bdfdmr5249070f8f.51.1794415733801; 
 Wed, 11 Nov 2026 08:48:53 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49944d646f9sm8244842f8f.32.2026.11.11.08.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 08:48:52 -0800 (PST)
Date: Wed, 11 Nov 2026 19:48:49 +0300
From: Dan Carpenter <dan@pereq.eu>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: gregkh@linuxfoundation.org, andy@kernel.org, error27@gmail.com,
 cenzhang@linux.microsoft.com, dennylin0707@gmail.com,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4] staging: fbtft: remove unused fbtft_init_dbg()
Message-ID: <avSccSGIsu1EbwnN@stanley.mountain>
References: <20261111163819.143147-1-himanshu.bakshi478@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111163819.143147-1-himanshu.bakshi478@gmail.com>
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 10:08:19PM +0530, himanshu bakshi wrote:
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> 
> The fbtft_init_dbg() macro is not being used, so delete it.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> ---
> Changes in v4:
> - Add Reviewed-by from Andy Shevchenko.
> 

Collecting the tags is unnecessary.  Maintainers handle it.  You should
do it if you have to resend for a different reason but otherwise just
leave it.

regards,
dan carpenter

