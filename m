Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92D3F36BAA
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 05:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AE9C10E0F8;
	Fri, 10 Apr 2026 05:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="U29Myxta";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3434510E0F8
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 05:32:23 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D7609348;
 Fri, 10 Apr 2026 07:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1775799052;
 bh=MUzr2P7i7loAzz0yoJoPeQX2W0yO5yBzzZ7X5jtgdwg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=U29MyxtatjfrbAl8dAc337PS4irKqQBEEgl9XgAe0gAR6n5NB9+lLOYajaR43ueRM
 8oI1vDH45I6jFxd5M7nspF2g7vKoN4ECowN/6qc8Bn+eGNusEJOL1UvxQ48DE5qOxM
 XkDE8TCtk8ISZRN8hWMbbuEAsa4jTS6tIrvL5Jbw=
Message-ID: <a22cea50-780c-4012-993b-189170c17077@ideasonboard.com>
Date: Fri, 10 Apr 2026 08:32:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/11] drm/fourcc: Add DRM_FORMAT_XV20
To: Simon Ser <contact@emersion.fr>
Cc: Vishal Sagar <vishal.sagar@amd.com>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Pekka Paalanen <ppaalanen@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
References: <20260325-xilinx-formats-v9-0-d03b7e3752e4@ideasonboard.com>
 <20260325-xilinx-formats-v9-2-d03b7e3752e4@ideasonboard.com>
 <aocdbgbLe5WhUEOGeLg3P7fRDM8i72H9zBuUnoAjjsuvBLfMPofrPtaUEjII_43KXf1wCbv1G9UutJKMkWLaEcBSnrlUV78Wrhu6l_Z0xi8=@emersion.fr>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <aocdbgbLe5WhUEOGeLg3P7fRDM8i72H9zBuUnoAjjsuvBLfMPofrPtaUEjII_43KXf1wCbv1G9UutJKMkWLaEcBSnrlUV78Wrhu6l_Z0xi8=@emersion.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 26/03/2026 16:26, Simon Ser wrote:
> On Wednesday, March 25th, 2026 at 15:02, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:
> 
>> XV20 is 2 plane 10 bit per component YCbCr 2x1 subsampled format. XV20
>> is similar to the already existing P030 format, which is 2x2 subsampled.
> 
> I don't know for sure the multi-planar YCbCr format name scheme we're
> using, but here are my observations looking at P, Q and S formats:
> 
> - The first digit indicates sub-sampling. 0 for 2x2, 2 for 2x1, 4 for none.
> - The two other digits indicate bits for the Y channel, one of 10, 12, 16.
>    One exception: Q401 indicates reverse order for Cb and Cr planes when compared
>    to Q410.
> 
> P030 is a bit of an outlier here since it's the only one with multiple
> Y samples. NV formats are also multi-planar but seem to use a completely
> separate scheme.
> 
> Given the above I'd say what would make most sense to me is to use P230:
> keep the last two digits and change the first one to indicate that the
> only difference is the sub-sampling. Does that make sense to you?
I'm fine with that.

  Tomi

