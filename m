Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4F3C98305
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 11:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BBEA10E6D7;
	Tue, 22 Sep 2026 11:34:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LJppHlip";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE97C10E6CC;
 Tue, 22 Sep 2026 11:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeHJQK0JfHq5OdZtlr+2HzgWPAz92+XBlz8OQ/bnFbEo88PT+7iTk8YNTtfxmxBQd1j8q2XWQp3/t/TZWdyukAQpRppYWiaRRalgvxBhaPcR0PguEiY8WI295EILemySIFvjLQeyXBCgbyocPCQlDINsjlyD4cAmz3cSRZAUwUDuptnVaKoAryCN0pqUvjIr2L84JcjdV+GVlwPeMyW/0Bh4veuT0uKXX9zH3V6Sppz6LIxBMm77yGNjq7z72AJmatU7ooGxYc4p/LLekkqlz8lW/UmShDtFVN7HRWsasdT8HlD81g8c4xbRaAvv8FrAng4tyEYINsn5HGkmvq5UfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZUcNIp1yitI6X8tr/Mw/UBDeLbzLuGqkbF/p0J8q8I=;
 b=D0QsgJliiS3vPj81tknZxxT9ljWNNX7THmzx+kfT6cVbPTM/cIThdXvOD3FZE04eF3cTqsUIvT1NWlSN6JAgEdgex9+h7MD0UD0KccTEioAaibX7IapH4UzgQs26fCqYAvtVPli2xogqCowuUXSSxEYvzttsuu23OgR6hH2d5MLGfEK/SdINLAVol/b/rO5nPBDNPlPrEmO57XorH/GhTOO4Xnm7x2EoMi1p5UIZo4X6aV8gg9Z9K8L/a/omQDMYcA9fwuinyD9vBCkVG2TGdgcKgNMXDi7Db8Wrl7cKBIR1cx3N/xL4SEH3jnbUlsqNyh8jiky2eA+47gC4kg/mGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZUcNIp1yitI6X8tr/Mw/UBDeLbzLuGqkbF/p0J8q8I=;
 b=LJppHlipL9ZBVwX0miMHANk1bP3Yd6VrKlSsylHutZzg/OHhtJ6FzrfWFyA2ZdGnUsIzoTwYUICy58ZZdzmKC1xAhihfqm3a07Tyqy2bzIdaQZ0wkV0kWwZsKJyKGE+uywFcxyXAzyF1gN1OSfD+XURoQsw394GyQwpODA6ayHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS4PR12MB634945.namprd12.prod.outlook.com (2603:10b6:8:514::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 11:34:55 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 11:34:55 +0000
Message-ID: <ff86caeb-4388-4660-b3c0-ddc42bc274e3@amd.com>
Date: Tue, 22 Sep 2026 06:34:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/14] backlight: add kernel-internal backlight API
Content-Language: en-US
To: Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>,
 David Herrmann <dh.herrmann@gmail.com>,
 Marta Lofstedt <marta.lofstedt@intel.com>,
 Mario Limonciello <superm1@kernel.org>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-3-mario.limonciello@amd.com>
 <0fb724cc-ac12-4502-b338-1c4f310f043a@suse.de>
 <CAFOAJEdFPrwHZV5y1E_u_Wd6oE_viPsPztxYW6PRZHJ-zdPFMQ@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAFOAJEdFPrwHZV5y1E_u_Wd6oE_viPsPztxYW6PRZHJ-zdPFMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR01CA0015.prod.exchangelabs.com (2603:10b6:5:296::20)
 To PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS4PR12MB634945:EE_
X-MS-Office365-Filtering-Correlation-Id: f17cb906-4599-4ce7-908c-08df189d85f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: M3q7yxv6U+nbKKWWNVf7b6nZFrd+TZ+tIKMrKXS4qmTxdpcAMehmJ9jRrZNGjHx541HsgDIXHRQb76GmB4/RmBU742ZSYDBRPXhUMN6jAmhPD02VHJY7Y99xrK9oFk7+lBNWEwetxUxO6vXaqpqVOO0jvw7K3O89jbYo22jsG4/ylspqouocl2Vcy2zAATEIuLAKQ5DNszWXRfOpm++FRUIBDJEXpwew1vI+k3RtNuLXTLwCPH4s2UCISklzFJJU2wJR2VT5Y2j0zZsP/yvjdu4IN0kTapxW8XGzKA0xVJOqCIr3KkVRfHIZCMpRJFuAO2kKQi7HnL9Q0SNPHXH//TOfFPd0dhe5g1ZFIJyEpEdV64ibawPCfYNtLyI3v3GM1zKw+HSXG1MvLJJ3EafTWU6jgzMmMg4lvD1zIUdql2IFZQfSKaxY0sz1n2hC0snxhCM/n0BF2fdgplV+zixpSIIYRZCDoAkGZx8aYSkDfVU/HSSGPq+knfTAdfwrIwBlfYfcm+j/zUDevjL7vN49cb3Hmlpqw8RdDmDUj2V1hlEE34AXJ3xvWBjrvnzbNeeLDuWlyHD/6tTlk3up7x06sgUu0fBQkrcr4L8a8tEoFloI+7kge4IOapll2jNK7GWGf28zfAoG+TgI51nFlINn2L1MBa4DRf0DudhD0yDcgFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0hqYWJOQ0tHS21BcUplU0t1bzFFejJETjZTNC9WTWY0WlZ6TlkyNTRKN3Zu?=
 =?utf-8?B?ano2cnUzOTc1YmZFZTd5N25OdWRXM0tLMkJMVzZlN0N3bEs5N210VFNNaHpQ?=
 =?utf-8?B?VmJqNFBia2pHNFNOc1o5c2tWVE5FeHNzZ0xiYWFoZWhWbkU2bXpPOTd6U3lK?=
 =?utf-8?B?bFlBMjFqbXd5WWdWTkZMdVRDK0owR1gyaHQ2STRkNUxoeWt6a09IMlROMktZ?=
 =?utf-8?B?aEpVSXNhTFZyT1B6L0lyYlptYi9TRVI2eWFIUjlreDdIbFplSWMvMHl3Z3Zr?=
 =?utf-8?B?ODJPNEs2anQvSEE5V3pvRlJPVWJmUXFNYktoV2RRcElsOWQvVTVENGpUM1dT?=
 =?utf-8?B?R0tYa1dKTlNrQWp1ZUp1NFlsT05xa0tyUTdtaVBMQ0ZLVHByNzdDalN6aG0r?=
 =?utf-8?B?SlF3cjdyY1NoY2xaU3R6cFhVak41K0EwcWt6ZHYyclJVMHoybG9KVmpPQmNp?=
 =?utf-8?B?Qmd4eHppWnhHeVhycEZ4cy9SbVhDMUFZcXh0Ump4Tld1RCtwOUdsR1gvSlMw?=
 =?utf-8?B?TmN2QVNUZWl4N0RwNi9UWjFUT2pUNDl2MXpJVVpDUlU1bExjd0dkekI3N2ZK?=
 =?utf-8?B?clcwMVQyYWxITWxUMXFUWUlYOG1mdzlnNU8rTS9HRHJ6RTFhSFlzQ1BaR3Z1?=
 =?utf-8?B?eE52aWlvWU44NDRnODJPNzZDN05FalYydzVxaU9UMzB2NnpDWnV4TlRGdVoy?=
 =?utf-8?B?VGRSVnNwT3FzbjZ4SzJKYnZmY3dvNVdIUEpXOE9ySzdLMGpTVFZXb3BMRjJi?=
 =?utf-8?B?aXVwcmJ6blJVaGYwNDAwVXc5RXNQYjl3ODE3RjRNSUs4Y1R3OFhUMkpjRW9W?=
 =?utf-8?B?VVZ6Y3pUMmtYRHF0VGdEMnp1QTlUUlEyT2lHNVM2b0ZCYmd5MmNGOC8rRWJh?=
 =?utf-8?B?TkpLK3FXVkVONUhETlIvdE44TkVzbjI1RzRYOHMwT2FjZkhBbUxHTHVwZkJN?=
 =?utf-8?B?MXhKQnpjQkI4YlFsZUpOQXNpc2JzaERFZTZmOFN6eWY1ZjNXTlBJUHdVSFFR?=
 =?utf-8?B?T1V3SmtCRmV6U2JmTGJ6cFRpdW9uTVpyVWV0T1VZUUZNcGl0QU1GN0tQcXY1?=
 =?utf-8?B?aFh2Nk8xN1pycEdEYkRkalJ1S2hta3JhZEs3ZDE0NWlzRWlIb3NiMlgvODZH?=
 =?utf-8?B?Z3pobW5haVQ3K0RCRnpvRG12c3pGSnNjVFdHQVVTamZSSUFFelBLZUhCdE5T?=
 =?utf-8?B?OFU3TzNiQVhzTnk4eThPdVpFdi94RUtKTG5aOGdIYmVTZmxrdUtWY2hRc1ox?=
 =?utf-8?B?Zk5yOFQzWnpFdzVtakFhVlV3dGROajBGNGpWOGt1a3MzNWZZWUJlM2g0Z0Ro?=
 =?utf-8?B?M3ZUZklBWjBaQTJnQjRjNE5kdWU1Y05MeDgzbVRNTjNHSXJkbnJObllNejVJ?=
 =?utf-8?B?SVpZWU1nWEpXZXJIS0Roem80TUxubFRYS3NVZTJ0OS9kNmVjbHFBNWpZQlhP?=
 =?utf-8?B?TXlqNSszN3JRU1dwYlc2YTdwc0dNZlo2SkxJUDFpN1Z6T24rYnI2UStkdkM2?=
 =?utf-8?B?U3B1RSs4VS80SXUvcjJweXM3YkFYQWJLRUZzQ2UzYWZjdzN0YktXenJMT1BK?=
 =?utf-8?B?SXpMY21MRWVOM013WTMrOHVQVll3Z2V4SUdFRUxJQjJBdlg0NWRYMG1KWXkx?=
 =?utf-8?B?TUFQWHVsR05DcURJM09uMWJTaWZGcmFpenBSZFRBV1k1eDNXZEUvQ294Vk9K?=
 =?utf-8?B?VGZuaTFEUW1GVytZM21EbkZuOEU5ZVc2UEFUQjNScU8zdW56UVRqRDE1KzlD?=
 =?utf-8?B?WUdFbFNwTnRwdlZ6N2NFd1dqZENrWEJrQllWUlRVVURYbDJOTDEvVzdLS3k0?=
 =?utf-8?B?UjRWeHlpNHNBZDA1N2V6SWVwTUV5a3VUcHJzSExwdE1HbFFoUTRweFkrc2Rz?=
 =?utf-8?B?cExJcVhYdWNxQk55aDVOZUF6MWdXZU5vYUg5TTdXYlRTcHNlZUdLZ3lRVDZt?=
 =?utf-8?B?eHhVbW5yVGEwMld1c1krR251N2s0WDdJWDltTWVBSG5yMXhJdVFYNUNYSlYw?=
 =?utf-8?B?RFFjVnJoenFGL2pzQWtxK084ZHJMT2s2dmFoUUNrUW5iTlNCQ2ZrQ2tiRllL?=
 =?utf-8?B?Y0JmSWxkQmxrK3pKeS9jL3hHYTJKK2NVZTdXcUlsdlFFTDZWMldiUWpLSHNu?=
 =?utf-8?B?cnBabXNjcUdZSytEUHovQVJOV3oxZ0tNemZZOTM0YnhESzFobmVTNTNSbXhu?=
 =?utf-8?B?S1lQYzd1S0NCQTB2TjNxbVRUOEZQUGJYWmMvNDVTV080TzlDZkRKY25lREhF?=
 =?utf-8?B?bm5iSXdjYlNpUVFQTTJIcGRGZnhSQmZkSDJxT3lybHBGY2kzSmhwNS9ZVG85?=
 =?utf-8?B?K2FEUnN4dGhic0RMZFU1Qmo4MDBBczZtcGkrK1FCYWF0dTRTbWYwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17cb906-4599-4ce7-908c-08df189d85f9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 11:34:54.9651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nr4f36vDHzRDMlG0Y5CU5vFRmPW5LPGDGZuxhI4TPbAw7azzAQjU+wDqidgjce6txW4nX/7jj7FxgpOBTcuBBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB634945
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



On 9/22/26 03:49, Javier Martinez Canillas wrote:
> On Tue, Sep 22, 2026 at 10:24 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>
>> Hi Mario
>>
>> Am 08.09.26 um 06:40 schrieb Mario Limonciello:
>>> So far backlights have only been controlled via sysfs. However, sysfs is
>>> not a proper user-space API for runtime modifications, and never was
>>> intended to provide such. The DRM drivers are now prepared to provide
>>> such a backlight link so user-space can control backlight via DRM
>>> connector properties. This allows us to employ the same access-management
>>> we use for mode-setting.
>>>
>>> This patch adds a few kernel-internal backlight helpers so we can modify
>>> backlights from within DRM, a brightness-changed notification, and a
>>> per-device takeover count so that legacy sysfs writes can be inhibited
>>> (-EBUSY) while a luminance-aware DRM client is in control.
>>>
>>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>>>
> 
> [...]
> 
>>> @@ -150,6 +153,13 @@ static ssize_t bl_power_store(struct device *dev, struct device_attribute *attr,
>>>        struct backlight_device *bd = to_backlight_device(dev);
>>>        unsigned long power, old_power;
>>>
>>> +     /* A luminance-aware DRM client has taken over this backlight; the
>>> +      * legacy sysfs interface is disabled until the last such client
>>> +      * goes away.
>>> +      */
>>> +     if (atomic_read(&bd->drm_takeover) > 0)
>>> +             return -EBUSY;
>>> +
>>>        rc = kstrtoul(buf, 0, &power);
>>>        if (rc)
>>>                return rc;
>>> @@ -214,6 +224,13 @@ static ssize_t brightness_store(struct device *dev,
>>>        struct backlight_device *bd = to_backlight_device(dev);
>>>        unsigned long brightness;
>>>
>>> +     /* A luminance-aware DRM client has taken over this backlight; the
>>> +      * legacy sysfs interface is disabled until the last such client
>>> +      * goes away.
>>> +      */
>>> +     if (atomic_read(&bd->drm_takeover) > 0)
>>> +             return -EBUSY;
>>
>> Can you really do that?  AFAIU sysfs is now a de-facto uapi for backlights.
> 
> And regardless if this can be done or not, I belive that would be
> better if this is something that drivers decide to do and just return
> -EBUSY from their struct backlight_ops..update_status.
> 
> Ideally the sysfs interface should continue to be work as Thomas said
> and a write could trigger a mode set for example, but I don't know if
> that is feasible to do due locking.
> 

Well the problem ends up being that something can change brightness 
behind the compositor's back if you leave sysfs available.

The whole design here is to put the compositor in control.  For example 
if compositor wants to enforce brightness to be a certain value when 
certain content is being displayed.
