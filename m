Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D6DC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5716B10E100;
	Tue,  8 Sep 2026 13:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HtNgWRof";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7358910E100
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:36:30 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-499de29beb7so1124965e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788874589; x=1789479389; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vkSrwpgV5JMC0Es79U5v7Gmcys29XZ3okUYq0XQB02Q=;
 b=HtNgWRofn1hWz30GX8Et6qr+6V62RfCTXhariqLX7ktiAqRMwCozKLuzt+rhg/fay6
 mKoxHUuLyDEyvJl9Pt3OsNJ0ecjWqfN8xFw2hV2PbLsh3PfgX5Fwjbex19OW2OJnzlKS
 ouGTa4sT11O45EWMHl1VKP8Jj3fbkl5vldFIAS700fTeB8ELkRVbi1OUyK7RnSDmVgfd
 HFbQHChqgRB21o7UeBv09VK9rx4d5UdHi69ty0ydJuEWwtuWjubz83Daz4KTu0DbFuN2
 Ufgn8K2FJ7WzMfWIThJEPsLnojeiUm8Xori8nq7TJul5XmOQ5j/+PAAoUocllYXRz1ik
 NP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788874589; x=1789479389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vkSrwpgV5JMC0Es79U5v7Gmcys29XZ3okUYq0XQB02Q=;
 b=JyHXJxFrLFnMvo6itzObewXb24UpmJ1hQBzXTwu6wM4KOnuWxQZH0oLGADJKltaJhM
 +tr5Qcp9TguwKGwGOULV5LeT/7slhpPy4105v2CwTS98SdnhKwtJWuHWkB/+fVgoX3ZF
 ndyQSEVYLFIr5A2Ok8TIwELmxXTl1OMXp0aC9DLCabWMOK2YYQCdUqTRqut6/nsZXRja
 YaAYfqDRVMFrc5dHkLeQ2mcj1k1icli0t8dWE9JXmFugPTIH6pfllSKRGbff81bOdIEP
 WSsxl3tYHPA16pbj8IAuMr+n00MKpAbhrrZB5c5dLCBcVEL4Xij7FvRLoC51TXs/pQsB
 7P0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMQrKFxlGvrWYYUQgJ8f0WHWmRK71Yl3Q14tZiIbzx5zSA9yu67I/E+TPhfPKvXZM42+F6A2haMIM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++klNlxx+ViO2rlIi/WAElQ+gLEsWy8cvvz27feF/M4ULncesCJS
 Ht7Tcl0lsZVlikEdk42RwdSGRMpckc5IqHtFlDYLbhvpUgeEuG2F3KCl
X-Gm-Gg: AYBFou2bFsm6RRkZPU+DPkA4SvORI0pwrmkf6+dQqroWDr7luI1gwh6PZD91fT3Q/JA
 k6FdKWKYBzpnRbK7YNKG6Qi0f38iU6fz9aGhNyGOTdpmEl8ovwuVRbrz4pcM6JPp9mxcj0mrSxq
 VMSxXXV3m30pbF7acMl+aeva7I737s4GL3fJ8j03You2ZKpaG3EPvdXHcteOmYN9GUpxgTObX5L
 wkzhdOAPlujR6nNCdz0ltc7fNAWdMEcgXn3sr8qjGq2GYIYE8wlMvJnU4tpobGaqrhAsfvGhgDT
 RUKtcWhBE8TFjRCgeK3W/UokUil7Xu+Txsy7/B/xXisM6pTl7JNPSxPiE0RzDtR6wJJkqvOmPnL
 HNmbHS9SQOU8OUDFAnH604qLfKTGC319OpNWjigbqEn4UfLbE4YEMrlpx+WkjacICpQ8repd4KN
 P4AfTCwMIK4OiHsrYojISpdvfadQ3B909qaYbvvoDB5Yp5wY5Mcon6xoDNWQ0EpApixF89VG1E0
 Zol2ODX5VEsjsVQ44kZkby29L9NWpbc+WTLKzPuU3HTodn6ntjacTmxkuw+7D2MpbK2
X-Received: by 2002:a05:600c:8b2e:b0:49c:cbf4:572b with SMTP id
 5b1f17b1804b1-49d01dcc1fdmr181152325e9.2.1788874588385; 
 Tue, 08 Sep 2026 06:36:28 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B825D0079B84A36A788F67A.dsl.pool.telekom.hu.
 [2001:4c4e:1b82:5d00:79b8:4a36:a788:f67a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfd3f815bsm293320765e9.4.2026.09.08.06.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 06:36:28 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Frank Zhang <rmxpzlb@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 dmitry.baryshkov@oss.qualcomm.com, heiko@sntech.de, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
Date: Tue,  8 Sep 2026 15:35:12 +0200
Message-ID: <20260908133513.9302-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ap_3zjRWm5-RXKKx@venus>
References: <20260908070220.41574-1-rmxpzlb@gmail.com> <ap_3zjRWm5-RXKKx@venus>
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

Hi Frank, Sebastian,

Just so the tag is not lost when the split goes away: what I tested and
what my Tested-by is about is the tmds_char_rate check on the path that
runs from hdmi_codec_shutdown(), not the introduction of the second
function. With ftrace I confirmed the check is what stops the register
access, so folding it back into the original function as Sebastian
suggests does not change anything I measured, and the tag applies to
that form as well.

If you would still rather have it re-tested on the simplified version,
send v6 and I will run the same reproducer and confirm.

Igor
