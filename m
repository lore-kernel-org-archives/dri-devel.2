Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A09C79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 03:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A103B10E269;
	Fri, 11 Sep 2026 03:42:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pIQyf3Zq";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 641D210E269
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:42:58 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cc4aa02a269so496600a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 20:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789098178; x=1789702978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:mime-version
 :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cS7AJAyUrXw4OKsQuXto2NRThO/NQ7LZ4I3G8/x/j7Y=;
 b=pIQyf3Zqd/E17pUO5lClOylpLDNAiSu2mIzl9tGaudya02wWpTIQwmNVdijYWNtQnw
 LBq4TMs8l78A/8E87PDgxQyij1xQvvPTJqxKHSHBFf46LDMysnStMQ8d7bw416DJigM3
 sZLG93JZoECsTBI2stZZXOkP/m+9XKriI1VXrPzjz7xkAy89nQa4RMdNoqbY5UAmv20B
 MjacMnIq68lBJeFYMS2+3iRRyfGCNaKo6VaOpiHXFMHcWWxHow+AeNBt4rtz9AACpFG8
 TbtkHuXK/GLQzbOQhryxHHBDhIX+K8CB9Jd0cVv2UBTS3dDdfHBmBfaiiAI0ZVmwvaH9
 hUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789098178; x=1789702978;
 h=content-transfer-encoding:content-type:in-reply-to:mime-version
 :user-agent:date:message-id:from:cc:references:to:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cS7AJAyUrXw4OKsQuXto2NRThO/NQ7LZ4I3G8/x/j7Y=;
 b=hZgRWMyzDHQVrXTWwyp1m/PqTsIVBLGejJtX85AiLzLekJlHSeJFpKDpuA8NZT09hK
 x5ded8XkuSxwYuaP7p6agLhpQuP7KohGdcxnUG8VceDiN8vknjm5wt/L6DjOSg00MrgW
 mCkMsJjd6k/nz3vTMNiyw53DGiq3j2OObqCAZPyazvmye5t7egRj7ITWE3b25qOumIsl
 UpelBbSqj9VWw+PA6cr5hMpwji5eyR3VL7I4v0HViQ2Zzvz1Zs93Tr9B4EENeI4aqYqE
 /mKYlNtCwq3rGZZ6OlB3PCrXUjMIj0OhkHNIydCH324XQOcLSLhk9vXzPmH7LTWB/KCk
 P+Og==
X-Forwarded-Encrypted: i=1;
 AKwUvByI5aoDNfRzgD0Jj03FtPOFRvK4w+IrnHkFzNvbBaaAO2KnoOVxrlaoJRCnNMk0Q7rQfGTjp79UYDs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kkJcurIQ2zxdfk8/ynJirrUnnoyCULSACk7O1o8Qwi8qSC2qMw
 sCf6Adyu0L/0kejq23+huUI9jnhOF+yfWkcDmP5jbaMO/M8wEULI1oIPFGa4ig==
X-Gm-Gg: AYBFou2UblDwY7TunoqvKTZ7Gbh7xxe5ZSdeMnikw4/AAA/LMZPqbGqCil0LTE9/DPk
 McozdcbmJDyX5IKJOb19J61N0mXhBqfahSaECnYMXZNEfUlYaBjW/ZK8CsxD0EoTLJOkpXXuNdH
 JeJ9Ae/H4D8bvDVWLronaAYRl3pxqqaznWmyk/qmklYr2cZeNJfc727x9kg6YiH+7d/4HZsCfnD
 TQpZ4fK8BX+7i9houi4cdFbestNDqFktAkC+uavme5YeS1xDi4anC+lgmUmPnK7G8nuQ+XIJDHG
 3CQEJCYNRRb4YfwXB2XXwgqKbVJAB6u1KsKkfVk2Y3vlMlOBHEDa/1I9iKFc8Bsmx71GHLq/Lut
 4wAUv2jY7mIboIIrwdxvkkAlRO19KZEPq/NLLg4BB2K8/doXqsm24UmCZ6HB1XGsdFNz/khUETk
 pl52cmTS6vszgMFg3acgM6iJQ9X16Tm+3Mo2IxQzKkbVTEQpsWPWo9gj27F3Fk0WGtNk/AFSz2X
 2p/cpGeA9pRB3cEHs3HJLzvnZLsEA==
X-Received: by 2002:a17:90b:1d45:b0:398:9be9:ab8f with SMTP id
 98e67ed59e1d1-39d9c21cf40mr3366244a91.20.1789098177800; 
 Thu, 10 Sep 2026 20:42:57 -0700 (PDT)
Received: from [10.1.1.24] (122-59-250-182-adsl.sparkbb.co.nz.
 [122.59.250.182]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d9d9ebeb1sm408602a91.4.2026.09.10.20.42.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Sep 2026 20:42:57 -0700 (PDT)
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Helge Deller <deller@gmx.de>, =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?=
 <miro.kropacek@gmail.com>
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
 <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
 <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com>
 <a8cb0e4f-a2fd-4478-99d6-fdb043a9d15c@gmx.de>
Cc: Linmao Li <lilinmao@kylinos.cn>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <6197fda7-889c-7f26-98ad-e0c56da66efa@gmail.com>
Date: Fri, 11 Sep 2026 15:42:49 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <a8cb0e4f-a2fd-4478-99d6-fdb043a9d15c@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
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

Thanks Helge,

Am 11.09.2026 um 08:39 schrieb Helge Deller:
>> All good then - do you need my Acked-by for Linmao's patch, Helge?
>
> No, I think your Reviewed-by is sufficient.
>
> But I added a
> Tested-by: Miro Kropáček <miro.kropacek@gmail.com>
> tag, if that's Ok for you, Miro?
> It's always good to know if a patch has been tested.
>
> With that, I just added the patch to the fbdev git tree.

All good then, much appreciated!

Cheers,

	Michael

>
> Thanks!
> Helge
