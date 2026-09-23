Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34153C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9955610E878;
	Wed, 23 Sep 2026 08:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bvcNkIgV";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19CFA10E878
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:59:03 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49c5a927a1fso167515e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 01:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790153941; x=1790758741; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N0deKAZvEUC2+qIm2qCL9XPw0JCTKVP9Fpq7a4fZNq8=;
 b=bvcNkIgVKVMmK7EyTRyNlpVP8/bN2ZIzULk9gnYwbMBOn1+e/+pcjmh2X97ZIGFbGQ
 5VInAOiMI3bXRaHZKdOLcwkRipcyEN3acGxZTkw+A5//DcAD6L7E+W43N8usWocbH2XV
 Ii69spt+e/uub3bXWNXD1FL0zhyfYOIoKEeTJgoS/3/lYTkpr/NVHUxlwi/kXukaBcyj
 lNkGUyZaT8Pq3bqS0kT5Acc7/Q48XzS/55FWtxwk1W4chKoP3i0bBL7G4Sfi8JBKFlWq
 UnB/7YPJJkTkTcV3yXNedrat8z5WAdX73T3xFyp+FCR63geBezILxk3CuwnKNXWPUhmc
 uokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790153941; x=1790758741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N0deKAZvEUC2+qIm2qCL9XPw0JCTKVP9Fpq7a4fZNq8=;
 b=ye3AWy4R8cEL4f4dWp9GhNdf/dRBWD+7oR+Ginjc9w6XM1Y6sgmWX+tDHfLkLAq9o1
 d0w1mMu47ApMAUd7/Bxzxu3oFmui66Q7ioG63rzfWff+VJ0qdI13wYXclXrOxSjDuf6d
 l3nbqcXcUf5WAT7yTqdSz0CddH7PAkFjiHSpbJp0GDq2imeFrI3BKGP3TEQknAuv4PCB
 iuTd40906pWCQoYQ61LYW7Tawre3PMGKBJLKL1++ZhmBsuHUeeskcpPvheuj5uUV6xoX
 ePA5Faev06JEODI59lC7IXnJVaOhEmnfKXYByeYbx8LTb2uSl788oKARnKCzf4Yd2WlS
 SIng==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSEeECuuddW1jEXTLdaHqHHj8UVeSVy7/vnQPH7jh87mWPeJpmYN82+6aZnvp4up5VAnAJe1GBoxM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kbxgsZayQu4r6WmBDHn+JFP0NgOAGVS7th3tjo17C1kx7ViqFZ
 JyJbxcw88fySSfS+zefjOApUUiipP8j3nRFvHLC53jp+92EBIR1SI3U6
X-Gm-Gg: AYBFou3b08eXgAihxpZGRQKGohaM8w6sGKW4waASH58SFKI8GjLttYFEaYLD/Hr94Dh
 e05tO+48bMlrd4o5Q00UxDx+wwy7TJ9qStLCZw45Y4pw8Gzbzx7fkmihfmHcCjDJOqigb7ZK45h
 i3n04SiysKaDmvipLnoCK1qCS8yUi/fXsc32dStH56FOJ7UByezZz6kRG1EnumgQO+MWaZFbUgs
 BZ1ZJ8Ck+5xvVaa/vufShqbfF/zDvhzDqi8ZVhwIBVvX6dhnLIzJ/uk0faRGI05HHQY3Qr1WPae
 jHRYegMcevaFSKRFZ6iS6ImvLrHD+kC19J94h3iZT99us1ta12+M7dtuENVaqLMTwyD+LACgj9d
 V6rkBC1csM0CSoH5kkjScCwi9beXdaoA1gUmvepz0/mfWC6h9OA8ZMO0d/7eROPlGI/j7yE6mRi
 VuunFvsGXKZVZEs1MfpKc1f0gD24yO7MNpr31mohUS+ZlJhsuuZ1EwRsOXymkxonxOtBaydjRuE
 O0LDEb727XTKqS+3pf2BjEcA88CCnXbZWVTFYw1Yg2yOOicQGbJvOgTO3Q9LuaoPZozlhSnNQXv
 R837
X-Received: by 2002:a05:600c:19d3:b0:499:d95a:41f with SMTP id
 5b1f17b1804b1-49fdec98921mr21435345e9.0.1790153941274; 
 Wed, 23 Sep 2026 01:59:01 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8F4500D949869966507951.dsl.pool.telekom.hu.
 [2001:4c4e:1b8f:4500:d949:8699:6650:7951])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe23d4288sm30177355e9.12.2026.09.23.01.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 01:59:00 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] dt-bindings: npu: rockchip: allow DVFS and
 thermal properties
Date: Wed, 23 Sep 2026 10:57:55 +0200
Message-ID: <20260923085755.16219-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922160602.GA3529337-robh@kernel.org>
References: <20260922080114.44662-1-royalnet026@gmail.com>
 <20260922080114.44662-7-royalnet026@gmail.com>
 <20260922160602.GA3529337-robh@kernel.org>
MIME-Version: 1.0
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

On Tue, Sep 22, 2026 at 11:06:02AM -0500, Rob Herring wrote:
> On Tue, Sep 22, 2026 at 10:01:09AM +0200, Igor Paunovic wrote:
> > Assisted-by: LLM checkpatch dt_binding_check
>
> Drop 'dt_binding_check'. That's expected/assumed.

Will do in v3. By the same reasoning I will drop 'dtbs_check' from the
two DTS patches, 07/11 and 11/11.

Igor
