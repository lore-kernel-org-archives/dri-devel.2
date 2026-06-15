Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FFBCD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF5310E116;
	Mon, 15 Jun 2026 11:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="L1CoGwL1";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6409A10E116
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 11:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781523239; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=f3VhkztPk/kgtEkhKAP2EdnPyqQLTw9nM+YofEgCV068vpd2BctMNGf2uTN+miGXZICpfc9EN1Y8Yy/gHncP+3q57L7XR+ed1c3cZQT+FB0FgfUvvVXEFOX00kQvIJJRKftaoySIL7qcdGI3IYVR4bYlJodUlCatQkajQTLSUpA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781523239;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DvS8gCXsM5VMwIEdLAl9nkhNM11jLZw+uR7WB4D1shU=; 
 b=N+R7htfGKotXGdT4cQyScq7Yd91daD5tlEiVuTMYFtgz75aFSEg0P4wOICB4AfhBiaF7jKkT6vfXxedP8BqUfQTn38EEONuYcePKPHSdGRKkr1TgTFbHBPO8kG7eYGQMFpwGraessVm6+s2SH1fdQh0BDp/PT/Av8AA0HRqNy1w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781523239; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=DvS8gCXsM5VMwIEdLAl9nkhNM11jLZw+uR7WB4D1shU=;
 b=L1CoGwL1oNoHtcOK3KWObxTPixqf3Z9YBOWo1KksKWhyI1tQGxcr9C043xj47GsX
 hpJjSn9ubAC3AcybisleFS0xdBs3Cp9coCIC0EBVniXmhE1fHnCV74x0qnAj7OnTI29
 2exmHoWiXk91HHa2CBkiJlBdwjn4tJsJTIbe1aLA=
Received: by mx.zohomail.com with SMTPS id 1781523237581955.8261400970574;
 Mon, 15 Jun 2026 04:33:57 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Stone <daniel@fooishbar.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH v3] drm/tests: Move test EDID data to separate .c file
Date: Mon, 15 Jun 2026 13:33:52 +0200
Message-ID: <F_lbTmMEQRW8DiEaOAuGPw@collabora.com>
In-Reply-To: <13d51fa273e6577004df793e77d62b76b7a5562e@intel.com>
References: <20260610-test-edid-array-definition-fix-v3-1-8ba947c1c453@collabora.com>
 <178121613344.363421.14550491021391307675.b4-review@b4>
 <13d51fa273e6577004df793e77d62b76b7a5562e@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Monday, 15 June 2026 11:59:12 Central European Summer Time Jani Nikula wrote:
> On Fri, 12 Jun 2026, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> > On Wed, 10 Jun 2026 18:43:43 +0200, Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> >> drm/tests: Move test EDID data to separate .c file
> >
> > Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> Thanks for the patch, review and testing, pushed to drm-misc-next.
> 
> BR,
> Jani.
> 

On that note, will Intel be picking up the Intel-specific patches from
the color format series as well? Unless they require further changes.

Would be a shame if Intel didn't have this property as well. :(

Kind regards,
Nicolas Frattaroli


