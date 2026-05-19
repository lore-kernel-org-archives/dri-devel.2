Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7D2CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 05:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C89DC10EA59;
	Tue, 19 May 2026 05:52:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="e/JEcU2q";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB27D10EA59
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 05:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779169966; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UP4YfN0bAPC1KZn/en/yI4GO+OZhGyP/c2SxadIeFiISF2ShDJThVZHRKM9qO+PaJWAT62E5KfnF02peu8nrVJ0lj1xwE3L7puDl/Y9sVSR/x/aRIpMtexpGfpzTIRIv91CWS82o35ka4iKvdOMP8BAlhsVCmdQEn55Pr1sKxyU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779169966;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=Qw2E5ESYGdq5xvgjtYV80S+aIbAByToeSLXkqWm/Ypo=; 
 b=b65qAvN6lb/5HIwcb4VqCoxChVlF8Zvm09u2cdYAIQ6kV/77wlus0dfrjTJ5ON4MuE+9e/Wnx3iHhpZe1bmBPPbqIOLhj2hPJP4aDqxPgZ7QNoDQ/VmTJyWB6L3oGxPMPoksZhC8uORUo+PRDAOvCAIQnPBDQInrtfLE2o+0oL0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779169966; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=Qw2E5ESYGdq5xvgjtYV80S+aIbAByToeSLXkqWm/Ypo=;
 b=e/JEcU2qZgaAv8ZDWWGY4M9nPLB+IqmatvdVc2oDdSdus/BRu4vJgngr+FFPhzhO
 H6LhJQjiUQ5qNtOXLiw8Kz8o4KFfugc6KQtqANZglDkrTh/5Ozt25OtEjYSkDqrTnY7
 lv2e3LJD42cXn2A08Blt/vYgyMGq0qQNVrH2+pYk=
Received: by mx.zohomail.com with SMTPS id 177916996523212.896496460932553;
 Mon, 18 May 2026 22:52:45 -0700 (PDT)
Message-ID: <8ff5d9cd-62bc-4136-af00-96acd3a2c07f@collabora.com>
Date: Tue, 19 May 2026 08:52:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] drm/virtio: Add support for saving and restoring
 virtio_gpu_objects
To: "Kim, Dongwon" <dongwon.kim@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@redhat.com" <airlied@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
References: <20260429204729.993669-1-dongwon.kim@intel.com>
 <20260429204729.993669-3-dongwon.kim@intel.com>
 <4ec04daf-9665-4b15-9e62-b83eb9aaa7c9@collabora.com>
 <PH0PR11MB5112A54866C6888080137302FA002@PH0PR11MB5112.namprd11.prod.outlook.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <PH0PR11MB5112A54866C6888080137302FA002@PH0PR11MB5112.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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

On 5/19/26 03:23, Kim, Dongwon wrote:
>> Can virtio_gpu_remove_from_restore_list() be moved to
>> virtio_gpu_cmd_unref_resource()?
> Yes, technically it can be done and we can remove some redundancy but
> don't you think adding it or removing it from the list would be better to be
> handled outside of vq functions (virtgpu_vq.c) where actual communication
> messages are processed?

cmd_unref() indeed isn't a good fit

Could you please check if list node can now be removed from
virtio_gpu_cleanup_object()? IIRC, there was a problem with that in
older patch versions.

-- 
Best regards,
Dmitry
