Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6237C606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=brYRrVQJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3156110E72E;
	Fri, 30 Oct 2026 01:15:41 +0000 (UTC)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33BA010E72E
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:15:35 +0000 (UTC)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d577so127216a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 18:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793322934; x=1793927734;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=rRObiLxIi2vrwq0UUfdqEG9ze93Cue7NnSCNvzSRWuYl1QhQ1Lubir558oQc9OKaOa
 zhXzaegVElL2XHniJCd9V8hQHbT8s9a4gS5L9ciCay/v3M+/2XKWDRMdCzp+A7iHChGU
 JEIZsYUxB5Wy9U+dqzzKWi2Xq7bTtCruaJjPcZFpxINhbe9oCyzyv29d/R1ytYDPPpNt
 oxvXaTqioHsQtefo5DvXq5If83xQ81+lI4LVWgj5GEGu3xDydsq7vG3mYbSEBq59Ce+8
 hQHhv6cIkrGjDqP9irhaLXlWu2lyXLLk+ZFvE1MyLLzejw1z5fmZgatoCEO9t7eUJXjQ
 MDjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuI6Mn/M0AD3d6C91PxQGbLJr6WtfDi4AZMs2na+d2DnlEDx5Xaq78M/S0u3XMTq6WYyGduhYn1Ro=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIG8PFz391mM1Y2PLI7vmbf48oZQCu/Ptn8xGqy1eiNksSzXc5a
 bXzUZ3D2T8F26my1TBuNMWaHpPC/1XmdkWW0/j7N0bWFSX8P7tKbuhJR6MpwBNrgub6Fm4eOk+R
 CJDPXy31M9nwONVQ1QncDiXBqFKy2S1AFAmqLj36MmR3MB+poPcKIh2ty9HKzASXrbspPJbqltI
 O59Z/RX23W35RDG6Esi14ftQ2zdoPKSm2O1mwWMBEZ/VEHlGE17mVb4+yE7x0IhsnpwYM06Si0B
 0u1cproCo8+T6vy3EoRM+OjxZ/x
X-Gm-Gg: AYBFou1f9SVyq3gzKrWEsZtl89NOoeD5psxB6WIyHx2oQIA8k22dGbTdGfHhKioyYFA
 kHYjAzlhL9N3k4Zy8bM/9zKMjfiEf9T7fHuNtT6MhbCy7MWiF3BwJIeWf1lOijJxG2YN/aIW0vm
 m9pfk/uJLWmI++X13bRctHzpPZ7PSBVusLM4MyWsmbWv7R+aMRgcFpVJFzl9L3Ai4ZhAUJlWo5X
 g88Hqfbrxc1MIO8Npoddb23PhozvQMxKpxNCFWmhanJOXvyahLm/XhFAhmqnpvcbja6aCno1Enx
 Gghvffh+lBlDOdscCHaDXME7gg18s9a4KIqgeh6QOh7OTMZkN0HTQ8UzPgaun83nYh+E9fmy/Ch
 K3TRTrLilJudFN7CkIb39+WlMAwt69+s9ck0K08ev0ZzHW0/QhjdCfv+dBCbVk7yXJlEzAWeW0c
 htP8CdSG5v06iTVchANIJwImFeKPcORyKsbue5VNGI
X-Received: by 2002:a17:90b:28d0:b0:3ab:36c4:b500 with SMTP id
 98e67ed59e1d1-3ae895743ddmr578143a91.5.1793322934497; 
 Thu, 29 Oct 2026 18:15:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae845e849bsm988500a91.7.2026.10.29.18.15.34
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Oct 2026 18:15:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5337b591609so1690371cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 18:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793322933; x=1793927733;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=brYRrVQJ6vb7qSH3QkLzeLKOowcnO4oowLAfW+KVk21lBk7rVBcHj6LxUXe7/Sm7SZ
 kKZLeSKBQENTvbD5iv9WALqau5D9e8xdCkX26JrgPx2cOjYU7AiY5IRykUgFRuJE72vo
 9rjg8lj49/0Rui6rvyw2xZ8HqbA2Mj4eSMDAs=
X-Forwarded-Encrypted: i=1;
 AKwUvByP8UU/E8S67gLmaAVQz0Swg7enLLNWhY08qWr3v+W2vT0QFWcpgnfXiOCw63LeBBDGItHPnKKN94c=@lists.freedesktop.org
X-Received: by 2002:a05:622a:a58a:b0:536:aafd:972e with SMTP id
 d75a77b69052e-542b62a117bmr12705021cf.24.1793322933044; 
 Thu, 29 Oct 2026 18:15:33 -0700 (PDT)
X-Received: by 2002:a05:622a:a58a:b0:536:aafd:972e with SMTP id
 d75a77b69052e-542b62a117bmr12704691cf.24.1793322932526; 
 Thu, 29 Oct 2026 18:15:32 -0700 (PDT)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54312a571fbsm269521cf.23.2026.10.29.18.15.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 18:15:32 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 18:16:53 -0700
Message-Id: <DMHRYAXZQ0NV.QGNFOA7HDQO0@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: log MOB limits outside the manager spinlock
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261029215700.3009996-1-zack.rusin@broadcom.com>
In-Reply-To: <20261029215700.3009996-1-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

