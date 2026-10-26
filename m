Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C09606A33B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OtaOyjQB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E7210EDB1;
	Mon, 26 Oct 2026 10:05:22 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE3310ED9E
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:05:08 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso24619745e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793009107; x=1793613907; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FxukyNQLWFXILJqtxON+jKNDyTFtWUyLnLvPqii2FBU=;
 b=OtaOyjQBq/G59gu+YAM1v2NmjK9uKTX+mFU2Cg8R+FHJJenNWDLF8wE79c2f6/8xSk
 6em9VCrg2qsxjG827leoRJhh9aoQS4oM4M4/hQ4qb0EDVisGeZllAguUJIFdAjp+YKhI
 PoXlCvTmX1ROQhOPO3wZvLABN9Kkn/OUX7NtsxKZP4YWq6aYrXc0sXcmYglKDVRL//qI
 a+VBUyfoDJorNfK5hVzCwA74wBZuyfLwpDgLqbum1iwXt1CU0s/EGuYG6pGmgeEvGCSt
 517KChQIi4KeWv3BVQ6tQB0Dkxw+T2PlHtZ/+bhL1qXx9Fiafc8JXDUBvTb+iCmjHBaU
 O1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793009107; x=1793613907;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FxukyNQLWFXILJqtxON+jKNDyTFtWUyLnLvPqii2FBU=;
 b=ayaEKJfDYiZsivqCfC3qvnJPG3QEmYjxaaaZ7tx5CztSkEvOlGsRrKyb7FsWjyQpY8
 NgsTVEl7K68gBY8kgsfH+KPAloXqGypi9SNZF6joCN4F2WvLwnqZksGc+yv7QjROdKyO
 7HjcuosK5F8Qdt2+r6odQnqLNlNBtm/GthvfcCmHcQuBpLI2hVAAruS8AiCl+Fw7catZ
 MJAYCiCIfUs6bugnp2OnUiUOzvFyRM/Pac4Zr6I8daPcdePzoOZkHeTp9yn0RZXxYdZO
 509Z/YfSp1pw2EWGWholBHP2vz3+tubqiQNHGC7bq0UxrwBAspvnuQSMlUV5mNGrb5+i
 KInw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0VYZrAWz35lw/OoWuno7a4HKBhSgkfjy2jY/EyqqcQbNs4bKFF+jMY3v0Ac7ueskVV/ujJG0sbko=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKfXgZdfTR8oDjvhxPwlxHs5C/W29nCkCYRnRN5iX6GeWxugAt2
 oXUmZF61Gc3GGMYEc4PQX+W05TD9UaOkCPkTW0+ezbATi+qdnUIPuwVKgILzYyd6LxUx15vF
X-Gm-Gg: AYBFou2nms+qS0xdxJ3jGAvM76yf+2LSA89y0rvKYU3aYP046f+7qm3HfRWR/Xiczru
 Qt3u8mVMPP0EvPSU/96f1GnVsokcJo31pRMSKhDy5t5zN8GGUsZ5/qpZn/lo7+ypVH7lCq48gAn
 Bwr//8OzIJ4xrmZsMqA0NXfNXHWy0VFl7V5eKVaTls7VryxhMZj2obOtmSXjIiBWd4P4cR2NEFB
 OVm+25/B95LjjIZMpqlIYAwhXvftAAHY5Z4s/Z++E8TxTfHS4sCBMUGQY0J/OI+ijBze58q0nbB
 xpZYYGMMBcZgvVHKN9jAyA1SFZhaDQwvWCboYYy4mp5BkEcbDhtiN9K2wF/RkleZd01bNdYZ9xL
 3ggwbjiHjrqvWipZLV4OgsSqQ08PInb1mUP2FKqJosYoYILchCDXi+7Lo4CtKfmGTBZUIlVfhHU
 qi66vCYr3rOPZSoQM1CoUdi6Q6rIc1A8dX12dmXmoL145xUiah8IK/CcNoNVOGn2VU6LDhqOaZt
 8VRUWgGLpvqJKMYWAQPolDCQQUIA0t1tB9sWldeF1XDtufqlgRZDWtqRJw9nBzm5RoYl2W1SQ==
X-Received: by 2002:a05:600c:870b:b0:4a1:777b:8a12 with SMTP id
 5b1f17b1804b1-4a35ac95981mr110653645e9.14.1793009106828; 
 Mon, 26 Oct 2026 03:05:06 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a55e99fsm187916495e9.4.2026.10.26.03.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:05:05 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:05:02 +0300
From: Dan Carpenter <error27@gmail.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
 cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: Remove unused fbtft_init_dbg()
Message-ID: <at8lztOr7xpvHEdo@stanley.mountain>
References: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 02:54:23PM +0530, himanshu bakshi wrote:
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> 
> The fbtft_init_dbg() macro is not being used, so delete it.
> 
> Reviewed-by: Dan Carpenter error27@gmail.com

This is formatted incorrectly.

> 

Don't add a blank line in the middle of the Tag block.
Tags are supposed to be in chronological order.  So Acks come
after the S-o-by tag.

> Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> ---

No v2 text.

Please, wait a day between resends, even for small things.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter

